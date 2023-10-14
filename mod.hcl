mod "zendesk_mod" {
  title         = "Zendesk"
  description   = "Zendesk mod containing standard pipelines."
  color         = "#03363D"
  documentation = file("./docs/index.md")
  icon          = "/images/flowpipe/mods/turbot/zendesk.svg"
  categories    = ["zendesk"]

  opengraph {
    title       = "Zendesk"
    description = "Zendesk mod containing standard pipelines."
    image       = "/images/flowpipe/mods/turbot/zendesk-social-graphic.png"
  }
}