<html>
<head>
	<meta charset="utf-8"/>
	<title>Source List</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
	    <#if showAnswer != 0>
	        <div style="display: inline-flex;">
            <table>
                <tr>
                    <td>
                        <a href="./Source" style="text-decoration: none">
                            <h1>题源目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                    </td>
                    <td>
                        <a href="./Problem?paperid=-1" style="text-decoration: none">
                            <h1>卷卷目录&nbsp; &nbsp;&nbsp;</h1>
                    </td>
                    <td>
                        <a href="./" style="text-decoration: none">
                            <h1>首页</h1>
                    </td>
                </tr>
            </table>
            <button class="bigFont" type="button" onclick="activeWholePaper(${idpaper})">Active All Problem in Paper</button>
            </div>
        </#if>

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
                                <#if problems[i].problemlevel == 1>
                                    <p>☆</p>
                                </#if>
                                <#if problems[i].problemlevel == 2>
                                    <p>☆☆</p>
                                </#if>
                                <#if problems[i].problemlevel == 3>
                                    <p>☆☆☆</p>
                                </#if>
                                <#if problems[i].problemlevel == 4>
                                    <p>☆☆☆☆</p>
                                </#if>
                            </td>
                            <td class="edge">
                                <p>${problems[i].modulename}&nbsp;&nbsp;</p>
                            </td>
                            <td class="edge">
                                <#if problems[i].problemstatus == 1>
                                    <p>Active</p>
                                <#else>
                                    <p>Hold</p>
                                </#if>
                            </td>
							
								<#if problems[i].workdetail??>
									<td class="edge">
										<p>${works[i]?size} &nbsp;&nbsp;</p>
									</td>
									<#if problems[i].workmark??>
										<#if problems[i].workmark == 0>
											<td><p class="right">通过</p></td>
										<#else>
											<td><p class="wrong">未通过</p></td>
										</#if>
                                    <#else>
                                        <td><p class="orange edge">待批</p></td>
									</#if>
									<td><p class="right edge">${problems[i].workdate}</p></td>
								<#else>
									<td class="edge">
										<p>未做</p>
									</td>
								</#if>
								<td class="edge">
								    <#list works[i] as work>
								        <#if work.workmark??>
								            <#if work.workmark == 0>
								                <#if work.usedtime == 0>
								                    <p class="edge" style="height: 20px; float:left; width:10px;background-color:green">${work.usedtime?c}</p>
								                <#else>
								                    <p class="edge" style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:green">${work.usedtime?c}</p>
                                                </#if>
                                            <#else>
                                                <#if work.usedtime == 0>
                                                    <p class="edge" style="height: 20px; float:left; width:10px;background-color:red">${work.usedtime?c}</p>
                                                <#else>
                                                    <p class="edge" style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:red">${work.usedtime?c}</p>
                                                </#if>
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
					<tr>
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
										Active
									</td>
								</#if>
								<#if problems[i].problemstatus == 2>
									<td class="bigFont">
										Not Active
									</td>
								</#if>
								<#if problems[i].problemstatus == 3>
									<td class="bigFont">
										Not Active
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
								<button class="bigFont" type="button" onclick="markWrongOnly(${problems[i].idwork?c}, ${problems[i].paperproblemid?c},  ${problems[i].idproblem?c})">WrongOnly</button>
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
				<#if noFormat == 0>
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
                </#if>
			</#list>
		</#if>
		
	</body>
	<script>
	    var idpaper = ${idpaper};
	    function activeWholePaper(_idpaper) {

            var url = "./Paper/activewholeproblem?idpaper="+idpaper;

            $.ajax({
                type: "POST", // 上传文件要用POST
                url: url,
                dataType : "json",
                processData: false,  // 注意：不要 process data
                contentType: false,  // 注意：不设置 contentType
                data: null,
                success: function(msg) {
                    window.location.reload();
                },
                error: function(msg) {
                    window.location.reload()
                }
            })
        }
	    function markWrongOnly(idwork, paperproblemid, idproblem) {
            var pData = {};
            pData.idwork=idwork;
            pData.workmark=1;
            pData.paperproblemid=paperproblemid;
            pData.idproblem=idproblem;

            var url = "./Work/wrong";
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