require("convert")

local input = [[
Hello world! Here is an equation: $$\frac{1}{2}$$ and another inline: $\Delta_K$.
]]

local sp = SplitTex(input)
for _, v in ipairs(sp) do
  print(v)
end
