fun! Html2haml()
  %!html2haml -r
  save %:r.haml
  setf haml
  !git rm %:r.erb
endfun

fun! RunCurrentSpec()
  let l:line = line(".")
  let l:str = "! script/spec ".bufname('%')." --line ".l:line
  exec l:str
endfun

