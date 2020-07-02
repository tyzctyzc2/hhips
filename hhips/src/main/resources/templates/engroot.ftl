<html>
<head>
	<meta charset="utf-8"/>
	<title></title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="./js/common.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
	    <#include "/header.ftl">
	    <div>
            <a href="./english/word/new" style="text-decoration: none">
                <h1>创建新词</h1>
        </div>
        <#list 0..partmax as i>
            <div class="sameLine">
                <a href="./english/part?partid=${partlist[i].idpart}" style="text-decoration: none">
                <p>${partlist[i].partname}---</p>
                <a href="./english/part?partid=${partlist[i].idpart}&showanswer=false" style="text-decoration: none">
                <p>Test &nbsp;&nbsp;&nbsp;&nbsp;</p>
            </div>
        </#list>
    </body>
</html>
