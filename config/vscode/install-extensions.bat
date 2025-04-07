for /f %%e in (%~dp0list-extensions.txt) do (
    code --install-extension %%e --force
)
