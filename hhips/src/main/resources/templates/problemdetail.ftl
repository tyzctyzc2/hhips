<html>
<head>
	<meta charset="utf-8"/>
	<title>Chapter View</title>
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
		<h1>题目历史</h1>
		<table>
			<tr class="edge">
				<td>
					<p>${problemdetail.problemindex}</p>
				</td>
				<td>
					<img id="myImage" class="center-fit" src=.\${problemdetail.problemdetail} />
				</td>
			</tr>	
		</table>
		<table>
			<tr class="edge">
				<td>
					<p>${problemdetail.problemlevel}</p>
				</td>
				<td>
					<img id="myImage" class="center-fit" src=.\${problemdetail.problemanswerdetail} />
				</td>
			</tr>	
		</table>
		<#if worklength != -1>
			<table>
					<#list 0..worklength as i>
						<tr class="edge">
							<td>
								<p>${works[i].workdate?string("yyyy_MM_dd")} &nbsp;  [${works[i].usedtime/60}]</p>
							</td>
							<td>
								<img id="myImage" class="center-fit" src=.\${works[i].workdetail} />
							</td>
						</tr>
					</#list>
			</table>
		</#if>
	</body>
</html>