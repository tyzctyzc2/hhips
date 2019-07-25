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
                },
                "check_callback" :  function (op, node, par, pos, more) {
                    //console.log("check_callback", node);
                    //console.log("check_callback", par);
                    if ((op === "move_node" || op === "copy_node") && node.type && node.type == "root") {
                        return false;
                    }
                    if ((op === "move_node" || op === "copy_node") && more && more.core ) {
                        if ((node != null) && (par != null) && (par.text != null)) {
                            console.log("will move...", node);
                            console.log("will move...", par);
                            if (confirm('Are you sure move ' + node.text + ' to ' + par.text)) {
                                var pData = {};
                                pData.tagId = node.id;
                                pData.newParentTagId = par.id;

                                $.ajax({
                                    type: "POST", // 上传文件要用POST
                                    url: "./tag/move",
                                    dataType : "json",
                                    processData: false,  // 注意：不要 process data
                                    contentType: "application/json",  // 注意：不设置 contentType
                                    data: JSON.stringify(pData),
                                    success: function(msg) {
                                        console.log('tag changed');
                                        console.log(msg);
                                        window.location.reload();
                                    },
                                    error: function(msg) {
                                        console.log(msg);
                                        window.location.reload()
                                    }
                                })
                                return true;
                            } else {
                                return false;
                            }
                        }
                    }
                    return true;
                }
            },
            "plugins" : [ "dnd" ]
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