f = SimpleForm("ntwon")
f.reset = false
f.submit = false
f:append(Template("ntwon/ntwon_log"))
return f
