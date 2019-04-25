<html>
<head>
	<meta charset="utf-8"/>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
    <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
	<title>题源</title>
</head>
	<body>
		<#include "/header.ftl">
		
		
		<#if sourcelength != -1>
			<table class="dmmtable" style="font-size:  x-large;">
					<#list 0..sourcelength as i>
						<tr>
							<td>
								<p>${sources[i].idsource?c}</p>
							</td>
							<td>
								<a href="./Chapter?sourceid=${sources[i].idsource?c}" style="text-decoration: none">
									<p>${sources[i].sourcename}</p>
								</a>
							</td>
							<td>
                                <a href="./edit#/sum?sourceid=${sources[i].idsource?c}&sourcename=${sources[i].sourcename}" style="text-decoration: none">
                                    <p>查看进度</p>
                                </a>
                            </td>
						</tr>	
					</#list>
			</table>
		</#if>
		

	</body>
</html>