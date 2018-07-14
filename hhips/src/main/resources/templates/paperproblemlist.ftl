<html>
<head>
	<meta charset="utf-8"/>
	<title>Source List</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<h1>${papername}</h1>
		<#if showAnswer != 0>
			<#if max != -1>
				<table>
					<#list 0..max as i>
						<tr class="edge">
							<td class="edge">
								<a class="jumper notLinkText" href="#jump_${problems[i].idproblem?c}">
								<p>${problems[i].problemindex}&nbsp;&nbsp;</p>
								</a>
							</td>
							<td class="edge">
								<p>${problems[i].problemlevel}&nbsp;&nbsp;</p>
							</td>
							
								<#if problems[i].workdetail??>
									<td class="edge">
										<p>${problems[i].usedtime?c} &nbsp;&nbsp;</p>
									</td>
									<#if problems[i].workmark??>
										<#if problems[i].workmark == 0>
											<td><p class="right">-------Pass-------</p></td>
										<#else>
											<td><p class="wrong">------Not Pass----</p></td>
										</#if>
									</#if>
								<#else>
									<td class="edge">
										<p>no work recorder</p>
									</td>
								</#if>
								<td class="edge">
								    <#list works[i] as work>
								        <#if work.workmark??>
								            <#if work.workmark == 0>
								                <p class="edge" style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:green">${work.usedtime?c}</p>
                                            <#else>
                                                <p class="edge" style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:red">${work.usedtime?c}</p>
                                            </#if>
                                        <#else>
                                            <p class="edge" style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:orange">${work.usedtime?c}</p>
                                        </#if>
                                    </#list>

                                </td>
							</tr>
					</#list>
				</table>
			</#if>
		</#if>
		
		<#if max != -1>
			<#list 0..max as i>
				<table style="font-size:  x-large;">
					<span id=jump_${problems[i].idproblem?c}></span>
					<tr class="edge">
						<td>
							<a href="./Problem?problemid=${problems[i].idproblem?c}">
								<img id="myImage" class="center-fit" src=.\${problems[i].problemdetail} />
							</a>
						</td>
					</tr>	
				</table>
				<#if showAnswer != 0>
					<#if problems[i].workdetail??>
						<table style="font-size:  x-large;">
							<tr class="edge">
								<td>
									${problems[i].usedtime?c}
								</td>
								<#if problems[i].problemstatus == 1>
									<td class="bigFont">
										Wait to do
									</td>
								</#if>
								<#if problems[i].problemstatus == 2>
									<td class="bigFont">
										Wait to mark
									</td>
								</#if>
								<#if problems[i].problemstatus == 3>
									<td class="bigFont">
										Done
									</td>
								</#if>
							</tr>
						</table>
						<table style="font-size:  x-large;">
							<tr class="edge">
								<td>
									<img id="myImage3" class="center-fit" src=.\${problems[i].workdetail} />
								</td>
								<#if problems[i].workmark??>
									<#if problems[i].workmark == 0>
										<button class="bigFont right" type="button" onclick="markRight(${problems[i].idwork?c}, ${problems[i].paperproblemid?c},  ${problems[i].idproblem?c})">Correct</button>
									<#else>
										<button class="bigFont wrong" type="button" onclick="markRight(${problems[i].idwork?c}, ${problems[i].paperproblemid?c},  ${problems[i].idproblem?c})">Correct</button>
									</#if>
								<#else>	
									<button class="bigFont" type="button" onclick="markRight(${problems[i].idwork?c}, ${problems[i].paperproblemid?c},  ${problems[i].idproblem?c})">Correct</button>
								</#if>
								<button class="bigFont" type="button" onclick="markWrong(${problems[i].idwork?c}, ${problems[i].paperproblemid?c},  ${problems[i].idproblem?c})">Wrong</button>
								<button class="bigFont" type="button" onclick="activeAgain(${problems[i].idwork?c}, ${problems[i].paperproblemid?c},  ${problems[i].idproblem?c})">ActiveOnly</button>
							</tr>
						</table>
					</#if>	
					<table style="font-size:  x-large;">
						<tr class="edge">
							<td>
								<img id="myImage2" class="center-fit" src=.\${problems[i].problemanswerdetail} />
							</td>
						</tr>
					</table>	
				</#if>
				<tr>
					<td>
						<br></br>
					</td>
					<td>
						<br></br>
					</td>
				</tr>
				<tr>
					<td>
						<br></br>
					</td>
					<td>
						<br></br>
					</td>
				</tr>
			</#list>
		</#if>
		
	</body>
	<script>
	    function activeAgain(idwork, paperproblemid, idproblem) {
            var pData = {};
            pData.idwork=idwork;
            pData.workmark=0;
            pData.paperproblemid=paperproblemid;
            pData.idproblem=idproblem;

            var url = "./Work/active";
            $.ajax({
                type: "POST", // 上传文件要用POST
                url: url,
                dataType : "json",
                processData: false,  // 注意：不要 process data
                contentType: false,  // 注意：不设置 contentType
                data: JSON.stringify(pData),
                success: function(msg) {
                    window.location.reload();
                },
                error: function(msg) {
                    window.location.reload()
                }
            })
        }
		function markRight(idwork, paperproblemid, idproblem) {
			var pData = {};
			pData.idwork=idwork;
			pData.workmark=0;
			pData.paperproblemid=paperproblemid;
			pData.idproblem=idproblem;
			
			var url = "./Work";
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: url,
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: JSON.stringify(pData),
				success: function(msg) {
			    	window.location.reload();
				},
				error: function(msg) {
			    	window.location.reload()
			    }
			})
		}
		function markWrong(idwork, paperproblemid, idproblem) {
			var pData = {};
			pData.idwork=idwork;
			pData.workmark=1;
			pData.paperproblemid=paperproblemid;
			pData.idproblem=idproblem;
			var url = "./Work";
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: url,
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: JSON.stringify(pData),
				success: function(msg) {
			    	window.location.reload();
				},
				error: function(msg) {
			    	window.location.reload()
			    }
			})
		}
	</script>
</html>