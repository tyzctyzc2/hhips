<html>
<head>
	<meta charset="utf-8"/>
	<title>Root</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="./js/common.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
	    <select class="bigFont floatRight" id="stageSelect" onchange="stageChanged()">
            <#list stages as stage>
               <option value=${stage.idStage}>${stage.stageName}</option>
           </#list>
       </select>
		<table class="center-fit down100">
            <tr>
                <td>
                    <h1 id="go2Source" class="edgeRound">题源目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="./Problem?paperid=-1" style="text-decoration: none">
                        <h1>卷卷目录</h1>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="./Report?wantday=${today}" style="text-decoration: none">
                        <h1>今日成绩</h1>
                </td>
            </tr>
        </table>
	</body>
	<script>
	    $(document).ready(function() {
            loadSettings();
            $("#go2Source").click(function(){
                  window.location.href = "./Source?stage=" + localStorage.stage;
            });
        });

        function loadSettings() {
            if (localStorage.stage) {
                $("#stageSelect").val(localStorage.stage);
            } else {
                $("#stageSelect").val(1);
                localStorage.stage = 1;
            }
        }

        function stageChanged() {
            localStorage.stage = $("#stageSelect").val();
        }
	</script>
</html>