<html>
<head>
	<meta charset="utf-8"/>
	<title>filter</title>
	<link href="./jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
    <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
    <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./jqueryui/jquery-ui.js"></script>
    <script type="text/javascript" src="./js/common.js"></script>
</head>
	<body>
	    <#include "/header.ftl">
	    <h1>标签分类</h1>
        <table style="font-size:  x-large;">
            <#list allTags as rowtag>
                <tr>
                <#list rowtag as tag>
                    <td class="edgeRound picked">
                        <a href="./tag?tagid=${tag.idtag}" style="text-decoration: none">${tag.tagname}</a>
                    </td>
                </#list>
                </tr>
            </#list>
        </table>
        <table style="font-size:  x-large;">
            <tr>
                <td>
                    <input class="bigFont" type="text" id="newTagName" />
                    <button class="bigFont" type="button" onclick="postTag()">+New Tag</button>
                </td>
            </tr>
        </table>

    </body>
</html>