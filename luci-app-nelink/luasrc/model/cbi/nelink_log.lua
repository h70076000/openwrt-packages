f = SimpleForm("nelink")
f.reset = false
f.submit = false
f:append(Template("nelink/nelink_log"))
return f
