require("tags")
require("convert")

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
            href = "https://fonts.googleapis.com/css2?family=Arimo:ital,wght@0,400..700;1,400..700&display=swap",
            rel="stylesheet"
        },
    }
end

local h_spacer = function ()
    return span {
        class = "h-spacer",
    }
end

local v_spacer = function ()
    return div {
        class = "v-spacer",
        " "
    }
end

local coursework_entry = function (semester, courses)
    return {
        span {
            style="font-weight: 600;",
            semester
        },
        span {
            courses
        },
    }
end

local stylesheet = [[
    :root {
        padding: 20px 10vw;
        font-family: "Arimo", serif;
        font-size: 20px;
    }
    h1 {
        margin: 0.2em 0em;
    }
    h2 {
        font-size: 28px;
        margin: 0.2em 0em;
    }
    p {
        line-height: 1.5em;
        padding: 0px 0vw;
        margin: 8px 0vw;
    }
    .h-spacer {
        margin: 0em 0.6em;
    }
    .v-spacer {
        margin: 1.6em 0em;
    }
    .nav-link {
        text-decoration: underline dotted;
        text-decoration-thickness: 0.05em;
        color: #a44a0b;
        transition: color 0.3s;
    }
    .nav-link:hover {
        color: #a44a0b;
        transition: color 0.3s;
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
        padding-top: 0.2em;
    }
]]

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
                "Lloyd Sangwoo Ko"
            },
            p {
                "I am a second-year undergraduate student at Brown University pursuing a B.S. in Applied Mathematics and a B.A. in Mathematics. I am broadly interested in PDEs and analysis.",
            },
            p {
                "I am currently studying the long-time behavior of solutions to incompressible Euler equations."
            },
            p {
                "You can find my CV ",
                a {
                    class="nav-link",
                    href="cv",
                    "here",
                },
                ". Some of my work can be found on ",
                a {
                    class="nav-link",
                    href="cv",
                    "GitHub",
                },
                ". Feel free to connect with me on ",
                a {
                    class="nav-link",
                    href="cv",
                    "LinkedIn",
                },
                ", or contact me at ",
                a {
                    class="nav-link",
                    href="cv",
                    "sangwoo_ko@brown.edu",
                },
                "."
            },
            -- Projects
            v_spacer(),
            h2 { "Projects" },
            p { "Long-Time Behavior of Solutions to Incompressible Euler Equations" },
            p { "Metric Geometry" },
            -- Teaching experience
            v_spacer(),
            h2 { "Teaching Experience" },
            p { "Experience 1" },
            p { "Experience 2" },
            -- Courses
            v_spacer(),
            h2 { "Coursework" },
            div {
                style = "display: grid; grid-template-columns: 1fr 4fr; margin-top: 8px",
                coursework_entry("Fall 2023", "Partial Differential Equations, Course 2"),
                coursework_entry("Spring 2024", "Some Other Course, Course 4"),
            }
        },
        div {
            img {
            id = "image",
                src = "me.png",
            }
        },
    },
}

SetSaveDir("pages")
SaveToHtml(document, "index")
