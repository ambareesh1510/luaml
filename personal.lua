require("convert")
require("tags")

SetSaveDir("pages")
SetTargetDocument("personal")

local stylesheet = [[
@font-face {
  font-family: "Lete Sans Math";
  src: url("../fonts/LeteSansMath.otf");
}
:root {
    padding: 20px 10vw;
    font-family: "Lato", serif;
    font-size: 20px;
}
math {
  font-family: "Lete Sans Math";
}
h1 {
    margin: 0.2em 0em;
}
h2 {
    font-size: 32px;
    margin-top: 0.4em;
    margin-bottom: 0.3em;
}
p {
    line-height: 1.5em;
    padding: 0px 0vw;
    margin: 12px 0vw;
}
.h-spacer {
    margin: 0em 0.75em;
}
.v-spacer {
    margin: 1.6em 0em;
}
.nav-link {
    text-decoration: none;
    color: #a44a0b;
    transition: color 0.3s;
}
.codeblock {
  margin: 0em;
  border: 1px solid black;
  padding: 0.4em;
}
#navbar {
    margin-bottom: 15px;
}
#main-content {
    padding-right: 5vw;
}
#wrapper {
    display: flex;
}
#image {
    width: 20vw;
}
.projects {
  margin-bottom: 0.5em;
  display: grid;
  grid-template-columns: 2fr 5fr 1fr;
}
math[display="inline"] {
  padding: 0em 0.2em;
}
.typst-svg {
  -- vertical-align: middle;
  padding: 0em 0.3em;
}
]]

local font_import = function()
    return {
      link {
        rel="stylesheet",
        type="text/css",
        href="https://cdn.jsdelivr.net/gh/dreampulse/computer-modern-web-font@master/fonts.css"
      },
      -- [[
      link {
          rel = "preconnect",
          href = "https://fonts.googleapis.com",
      },
      link {
          rel = "preconnect",
          href = "https://fonts.gstatic.com",
          crossorigin = nil
      },
      link {
          href = "https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap",
          rel="stylesheet"
      },
      -- ]]
    }
end

local h_spacer = function ()
    return span {
        class = "h-spacer"
    }
end

local v_spacer = function ()
    return div {
        class = "v-spacer",
        " "
    }
end

local codeblock = function (str)
  return pre {
    class = "codeblock",
    code {
      str:gsub("<", "&lt;"):gsub(">", "&gt;"),
      nil -- must include nil here because string:gsub returns two values
    }
  }
end

local project = function (title, desc, links, date)
  local proj = div {
    class = "projects",
    div {
      div {
        style="font-weight: 700",
        title
      },
    },
    span {
      desc
    },
    span {
      style = "text-align: right;",
      date
    }
  }
  for _, link in pairs(links) do
    proj[1][#proj[1]+1] = a {
      class = "nav-link",
      href = link[2],
      "[" .. link[1] .. "] "
    }
  end
  return proj
end

local document = Html {
    head {
        font_import(),
        style {stylesheet},
    },
    div {
        id = "wrapper",
        div {
            id = "main-content",
            h1 {
                "Ambareesh Shyam Sundar"
            },
            div {
                id = "navbar",
                a {
                    class="nav-link",
                    href="cv",
                    "CV",
                },
                h_spacer(),
                a {
                    class="nav-link",
                    href="mailto:ambareesh@gatech.edu",
                    "Email",
                },
                h_spacer(),
                a {
                    class="nav-link",
                    href="https://github.com/ambareesh1510",
                    "GitHub",
                },
                h_spacer(),
                a {
                    class="nav-link",
                    href="https://example.com",
                    "Blog",
                },
            },
            p {
                "I am an undergraduate student at Georgia Tech studying Mathematics and Computer Science. My interests include combinatorial perspectives on algebraic problems, algorithms, and computing.",
            },
            p {
              "I am currently doing research with the Georgia Tech Mathematical Neuroscience Group, under the guidance of Prof. Hannah Choi."
            },
            p {
              "In my spare time, I enjoy composing and playing music, reading, playing video games, and crocheting."
            },
            h2 { "Projects" },
            div {
              id = "projects",
              project(
                "Dungeon Deja Vu",
                "A platformer created for the Bevy Jam 5 with a unique cyclic twist.",
                {
                  {"GitHub", "https://github.com/ambareesh1510/dungeon-deja-vu"},
                  {"Itch", "https://dsfhdshdjtsb.itch.io/dungeon-deja-vu"},
                },
                "July 2024"
              ),
              project(
                "Coda",
                "A scripting language for music synthesis.",
                {
                  {"GitHub", "https://github.com/ambareesh1510/coda"},
                },
                "Dec 2023"
              ),
              project(
                "Chaotic Hash Functions",
                "Benchmarking the effectiveness of hash functions implemented using chaotic discrete maps.",
                {
                  {"GitHub", "https://github.com/ambareesh1510/chaotic-hash-functions"},
                },
                "Nov 2023"
              ),
            },
            -- div {
            --   "Minkowski's bound gives us that",
            --   typ([[$$M_K = \sqrt{|\Delta_K|} \cdot \left(\frac{4}{\pi}\right)^{r_2} \frac{n!}{n^n}$$]]),
            --   "where",
            --   typ([[$r_2$]]),
            --   "is the number of complex embeddings of",
            --   typ([[$K$]]),
            --   "into",
            --   typ([[$\mathbb{C}$]]),
            --   ".",
            -- },
            div {
              SplitTex([[Here is some inline math: $Delta_K$, and some display math: $ integral_0^infinity e^(-x^2) dif x $]]),
              SplitTex([[$ H lt.tri G $]]),
              SplitTex([[$ H <= G $]]),
              SplitTex([[$ cal(O)_K $]]),
            },
            codeblock([[
#include <stdio.h>

int main(char *argc, char **argv) {
    printf("Hello, world!\n")
}
              ]])
        },
        div {
            img {
            id = "image",
                src = "../../me.png",
            }
        },
    },
}

SaveToHtml(document, "personal")
