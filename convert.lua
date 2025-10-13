local lfs = require "lfs"
local save_dir = "."
local save_path = "index"
local TYPST_SAVE_PREFIX = "__typst_"
local typst_svg_index = 1
local TYPST_PREAMBLE = [[
#set page(width: auto, height: auto, margin: 0pt)
#set text(font: "Lato")
#show math.equation: set text(font: "Lete Sans Math", features: ("cv11",))

]]

ConvertToHtml = function (inner)
    local s = ""
    if type(inner) == "string" then
        s = s .. inner
        return s
    end
    if type(inner) ~= "table" then
        error("Invalid HTML: expected table, found " .. type(inner))
    end

    if inner.__tag ~= nil then
        s = s .. "<" .. inner.__tag
        for k, v in pairs(inner) do
            if type(k) == "string" and k ~= "__tag" and type(v) == "string" then
                if v == nil then
                    s = s .. " " .. k
                else
                    s = s .. " " .. k .. "=\"" .. v .. "\""
                end
            end
        end
        s = s .. ">"
    end
    for i = 1, #inner do
        s = s .. ConvertToHtml(inner[i])
    end
    if inner.__tag ~= nil then
        s = s .. "</" .. inner.__tag .. ">"
    end
    return s
end

SetSaveDir = function (dir)
    save_dir = dir
    -- lfs.chdir(save_dir)
    print(lfs.currentdir())
end

SetTargetDocument = function (path)
    save_path = path
    typst_svg_index = 1
end

SaveToHtml = function (inner)
    local converted = "<!DOCTYPE html>" .. ConvertToHtml(inner) .. "\n"
    lfs.mkdir(save_dir)
    local full_path = save_dir .. "/" .. save_path .. "/index.html"
    local save_file = io.open(full_path, "w")
    print("Writing to", full_path, save_file)
    io.output(save_file)
    io.write(converted)
end

function FirstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

typ = function (str)
    local svg_dir = save_dir .. "/" .. save_path .. "/"
    lfs.mkdir(save_dir)
    lfs.mkdir(svg_dir)
    -- local svg_path = svg_dir .. TYPST_SAVE_PREFIX .. typst_svg_index .. ".svg"
    local tex_path = svg_dir .. TYPST_SAVE_PREFIX .. typst_svg_index .. ".tex"
    -- local cmd =  "typst c -f svg - " .. svg_path .. " <<< " .. "\'" .. TYPST_PREAMBLE .. str .. "\'"
    local cmd =  "pandoc -f typst -t html --mathml -o " .. tex_path .. " <<< \'" .. str .. "\'"
    print(cmd)
    os.execute(cmd)
    local written_svg = io.open(tex_path, "rb")
    local svg_content = written_svg:read("*all")
    svg_content = string.sub(svg_content, 4, string.len(svg_content) - 5)
    written_svg:close()
    typst_svg_index = typst_svg_index + 1
    return {
        -- class = "typst-svg",
        svg_content
    }
    -- return img {
    --     class = "typst-svg",
    --     src = TYPST_SAVE_PREFIX .. typst_svg_index .. ".svg"
    -- }
end

local function split_preserve_dollar(s)
    local result = {}
    for text, dollars in s:gmatch("([^$]*)(%$+)") do
        if text ~= "" then
            table.insert(result, text)
        end
        table.insert(result, dollars)
    end

    -- Capture any trailing text after the last `$` sequence
    local last = s:match("[^$]*$")
    if last ~= "" then
        table.insert(result, last)
    end

    return result
end

SplitTex = function(str)
    local result = {}
    local split_dollar = split_preserve_dollar(str)
    -- local inline_mode = false
    -- local display_mode = false
    local math_mode = false
    local acc = ""
    for _, v in ipairs(split_dollar) do
        if v == "$" or v == "$$" then
            acc = acc .. v
            if math_mode then
                table.insert(result, typ(acc))
                acc = ""
            end
            math_mode = not math_mode
        else
            if math_mode then
                acc = acc .. v
            else
                table.insert(result, v)
            end
        end
    end
    return result
end
