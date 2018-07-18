<html>
<head>
	<meta charset="utf-8"/>
	<title>Chapter List</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<table>
            <tr>
                <td>
                    <a href="./Source" style="text-decoration: none">
                        <h1>题源目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                </td>
                <td>
                    <a href="./Problem?paperid=-1" style="text-decoration: none">
                        <h1>卷卷目录</h1>
                </td>
            </tr>
        </table>
		<h1>Today</h1>
		<table>

		<#if maxseg != -1>
		<#list 0..maxseg as i>
		    <tr>
		    <td>${segworks[i].startdate?time}</td>
            <td>
		    <#if segworks[i].workmark != 0>
                <p class="edge" style="height: 20px; float:left; width:${segworks[i].usedtime?c}0px;background-color:green">${segworks[i].usedtime?c}</p>
            <#else>
                <p class="edge" style="height: 20px; float:left; width:${segworks[i].usedtime?c}0px;background-color:red">${segworks[i].usedtime?c}</p>
            </#if>
            </td>
            </tr>
		</#list>
		</#if>

		</table>
	</body>
</html>