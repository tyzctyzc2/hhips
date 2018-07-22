<html>
<head>
	<meta charset="utf-8"/>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
    <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
	<title>Source List</title>
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
                        <h1>卷卷目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                </td>
                <td>
                    <a href="./" style="text-decoration: none">
                        <h1>首页</h1>
                </td>
            </tr>
        </table>
		
		
		<#if sourcelength != -1>
			<table style="font-size:  x-large;">
					<#list 0..sourcelength as i>
						<tr class="edge">
							<td>
								<p>${sources[i].idsource?c}---</p>
							</td>
							<td>
								<a href="./Chapter?sourceid=${sources[i].idsource?c}" style="text-decoration: none">
									<p>${sources[i].sourcename}</p>
								</a>
							</td>
						</tr>	
					</#list>
			</table>
		</#if>
		

	</body>
</html>