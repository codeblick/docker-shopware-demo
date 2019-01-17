{extends file="parent:frontend/index/index.tpl"}

{block name="frontend_index_after_body" prepend}
    {include file="frontend/_includes/messages.tpl" type="warning" content="Dieser Demshop von <a href='https://www.codeblick.de'>codeblick</a> enthält keine richtigen Produkte und wird nur zur Demonstration von Plugins benutzt! <a href='https://www.codeblick.de/impressum'>Zum Impressum</a>"}
{/block}
