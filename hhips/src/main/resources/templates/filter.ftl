<html>
<head>
	<meta charset="utf-8"/>
	<title>filter</title>
	<link href="./jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
	<link href="./default/style.min.css" rel="stylesheet" type="text/css" media="all">
    <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
    <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./jstree.min.js"></script>
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
        <div id="container">
            <ul>
                <li>Root node
                    <ul>
                        <li>dej
                            <ul>
                                <li>Child node 1</li>
                            </ul>
                        </li>
                        <li>Child node 2</li>
                    </ul>
                </li>
            </ul>
            <br>
        </div>
    </body>
    <script>
        $("#container").jstree({
            "core":{
                "data":{
                    "url": "./childtag?rootid=1",
                    "dataType": "json"
                }
            }
        })
        .on('loaded.jstree', function() {
            $("#container").jstree('open_all');
        });
        $("#container").on(
            "select_node.jstree", function(evt, data){
                console.log(data.node.id);
                window.open('./tag?tagid='+data.node.id);
            }
        );
    </script>
</html>