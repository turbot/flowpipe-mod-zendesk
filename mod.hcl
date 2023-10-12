mod "zendesk_mod" {
  title         = "Zendesk"
  description   = "Zendesk mod containing standard pipelines."
  color         = "#FCA121"
  documentation = file("./docs/index.md")
  icon          = "/images/flowpipe/mods/turbot/zendesk.svg"
  categories    = ["zendesk"]

  opengraph {
    title       = "Zendesk"
    description = "Zendesk mod containing standard pipelines."
    image       = "/images/flowpipe/mods/turbot/zendesk-social-graphic.png"
  }
}