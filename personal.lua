require("convert")
local md = require("md")
require("tags")

local stylesheet = [[
@font-face {
  font-family: "Lete Sans Math";
  src: url("./fonts/LeteSansMath.otf");
}
:root {
    color-scheme: light dark;
    padding: 20px 10vw;
    font-family: "Lato", serif;
    font-size: 20px;
}
#wrapper {
    display: grid;
    grid-template-columns: 3fr 1fr;
    align-items: start;
}
.sidebar img {
    width: clamp(150px, 100%, 400px); 
    aspect-ratio: 1 / 1;
    object-fit: cover;
    display: block;
}
@media (max-width: 700px) {
  #wrapper {
    grid-template-columns: 1fr;
  }
  #main-content {
      padding-right: 0vw;
  }
  .sidebar {
    display: none;
  }
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
a, a:visited {
    text-decoration: none;
    color: LinkText;
}

#theme-toggle {
    cursor: pointer;
    color: VisitedText;
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
#image {
    width: 20vw;
}
ul {
    margin: 0em;
}
.bullet {
  margin-bottom: 0.3em;
}
math[display="inline"] {
  padding: 0em 0.2em;
}
]]

local font_import = function()
    return {
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
    class = "bullet",
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
      href = link[2],
      "[" .. link[1] .. "] "
    }
  end
  return proj
end

local writing = function (title, links)
  local proj = div {
    class = "bullet",
    li {
      title,
    },
  }
  for _, link in pairs(links) do
    proj[1][#proj[1]+1] = a {
      href = link[2],
      "[" .. link[1] .. "] "
    }
  end
  return proj
end

local document = Html {
    head {
        meta { charset = "utf-8" },
        font_import(),
        style {stylesheet},
    },
    body {
        div {
            id = "wrapper",
            -- class = "layout",
            div {
                id = "main-content",
                h1 {
                    "Ambareesh Shyam Sundar"
                },
                div {
                    style = "display:flex;gap:10px",
                    a {
                        "Email",
                        href="mailto:ambareesh@gatech.edu",
                    },
                    "&middot;",
                    a {
                        "Github",
                        href="https://github.com/ambareesh1510",
                    },
                    "&middot;",
                    a {
                        "LinkedIn",
                        href="https://linkedin.com/in/ambareesh-shyam-sundar",
                    },
                    "&middot;",
                    a {
                        "Resume",
                        href="resume.pdf",
                    },
                    "&middot;",
                    span {
                        "Switch theme",
                        id = "theme-toggle",
                    },
                    script {
                        [[
                        const root = document.documentElement;
                        const toggle = document.querySelector("#theme-toggle");
                        const systemTheme = window.matchMedia("(prefers-color-scheme: dark)");

                        function updateThemeLabel() {
                            const isDark = document.documentElement.style.colorScheme
                                ? document.documentElement.style.colorScheme === "dark"
                                : systemTheme.matches;

                            toggle.textContent = isDark ? "Light mode" : "Dark mode";
                        }

                        toggle.addEventListener("click", () => {
                            const current = getComputedStyle(root).colorScheme;
                            root.style.colorScheme = current.includes("dark") ? "light" : "dark";
                            updateThemeLabel();
                        });

                        updateThemeLabel();
                        ]]
                    },
                },
                p {
                    [[
                    I am a fourth-year undergraduate student at Georgia Tech studying Computer Science and Mathematics.
                    I am broadly interested in designing high-performance computing systems, especially from the perspective of hardware-software codesign.
                    I am also interested in applications of these systems to scientific computing, machine learning, and robotics.
                    Currently, I am a teaching assistant for Georgia Tech's CS 4803/6222: Systems for Machine Learning.
                    ]]
                },
                p {
                    md[[
                    In summer 2026, I was a Data Security Intern at 1Password, where I worked on refactoring and improving the open-source Rust library [passkey-rs](https://github.com/1Password/passkey-rs).
                    In summer 2024, I worked as a Software Engineering Intern at the Georgia Tech Open Source Program Office and collaborated with mentors from IBM to contribute to [PyTorch](https://github.com/pytorch/pytorch).
                    ]]
                },
                p {
                    md[[
                    From 2024 to 2026, I worked as a student researcher at the [Georgia Tech Mathematical Neuroscience Lab](https://hannahchoi.math.gatech.edu/), where I helped design and implement computationally efficient machine learning models for computer vision using insights from animal biology.
                    ]]
                },
                h2 { "Writing" },
                ul {
                  writing(
                    "\"Above and Below: Matroids and Generalizations via Greedy Algorithms\", expository paper (2025). ",
                    {
                        {"pdf", "Above_and_Below_Matroids_and_Generalizations_via_Greedy_Algorithms.pdf"}
                    }
                  ),
                  writing(
                    "\"Gröbner Bases\", expository paper (2025). ",
                    {
                        {"pdf", "Grobner_Bases.pdf"}
                    }
                  ),
                  writing(
                    "\"Sphere Packing and the Geometry of Numbers\", expository paper (2025). ",
                    {
                        {"pdf", "Sphere_Packing_and_the_Geometry_of_Numbers.pdf"}
                    }
                  ),
                  writing(
                    "\"A Self-Contained Introduction to Khovanov Homology\", expository paper (2025). ",
                    {
                        {"pdf", "A_Self_Contained_Introduction_to_Khovanov_Homology.pdf"}
                    }
                  ),
                },
                h2 { "Projects" },
                ul {
                  writing(
                    span {
                      strong {
                        "Foxtail, ",
                      },
                      "a Unix-like 32-bit x86 operating system written in C. ",
                    },
                    {
                      {"Github", "https://github.com/ambareesh1510/foxtail"},
                    }
                  ),
                  writing(
                    span {
                      strong {
                        "How the Turntables, ",
                      },
                      "an original rhythm game that won 12th place in the ",
                      a {
                        "Juniper Dev Game Jam",
                        href = "https://itch.io/jam/theveryseriousjuniperdevgamejam",
                      },
                      ". ",
                    },
                    {
                      {"Itch", "https://dsfhdshdjtsb.itch.io/howtheturntables"},
                    }
                  ),
                  writing(
                    span {
                      strong {
                        "Open Aim Trainer, ",
                      },
                      "a lightweight open source FPS aim trainer with scriptable and customizable scenarios. ",
                    },
                    {
                      {"Github", "https://github.com/ambareesh1510/openaimtrainer-frontend"},
                    }
                  ),
                  writing(
                    span {
                      strong {
                        "Dungeon Deja Vu, ",
                      },
                      "a platformer created for the Bevy Jam 5 with a unique cyclic twist. ",
                    },
                    {
                      {"Github", "https://github.com/ambareesh1510/dungeon-deja-vu"},
                      {"Itch", "https://dsfhdshdjtsb.itch.io/dungeon-deja-vu"},
                    }
                  ),
                  writing(
                    span {
                      strong {
                        "Coda, ",
                      },
                      "a scripting language for music synthesis. ",
                    },
                    {
                      {"Github", "https://github.com/ambareesh1510/coda"},
                    }
                  ),
                  writing(
                    span {
                      strong {
                        "Chaotic Hash Functions, "
                      },
                      "benchmarking the effectiveness of hash functions implemented using chaotic discrete maps. ",
                    },
                    {
                      {"Github", "https://github.com/ambareesh1510/chaotic-hash-functions"},
                    },
                    "Nov 2023"
                  ),
                },
            },
            div {
                class = "sidebar",
            },
        },
    }
}

SetSaveDir("pages")

SetTargetDocument("index")
SaveToHtml(document)
