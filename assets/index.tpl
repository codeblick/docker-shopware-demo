{extends file="parent:frontend/index/index.tpl"}

{block name="frontend_index_after_body" prepend}
    {include file="frontend/_includes/messages.tpl" type="warning" content="Dieser Demoshop von <a href='https://www.codeblick.de'>codeblick</a> enthält keine richtigen Produkte und wird nur zur Demonstration von Plugins benutzt! Impressum und Informationen zum Datenschutz finden Sie auf unserer Webseite."}
{/block}
