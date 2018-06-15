<html>
<head>
	<meta charset="utf-8"/>
	<title>Source List</title>
	<script type="text/javascript" src="/hhipsair/jquery-3.3.1.min.js"></script>
	<style>
		* {
			margin: 0;
			padding: 0;
		}
		.imgbox {
			display: grid;
			height: 100%;
		}
		.center-fit {
			max-width: 100%;
			max-height: 100vh;
			margin: auto;
		}
		.edge {
			box-shadow: 0px 0px 2px 2px rgba(0,0,255,.4);
		}
		.bigFont {
			font-size: xx-large;
		}
		.right {
			color:green;
		}
		.wrong {
			color:red;
		}
	</style>
</head>
	<body>
		<h1>${papername}</h1>
		<#if max != -1>
			<table style="font-size:  x-large;">
					<#list 0..max as i>
						<tr class="edge">
							<td>
								<img id="myImage" class="center-fit" src=${problems[i].problemdetail} />
							</td>
						</tr>	
						<#if showAnswer != 0>
							<#if problems[i].problemstatus != 0>
								<tr class="edge">
									<#if problems[i].workdetail??>
										<td>
											<img id="myImage3" class="center-fit" src=${problems[i].workdetail} />
										</td>
									</#if>
									<td>
										${problems[i].usedtime}
									</td>
									<td>
										<#if problems[i].workmark??>
											<#if problems[i].workmark == 0>
												<button class="bigFont right" type="button" onclick="markRight(${problems[i].idwork})">Correct</button>
											<#else>
												<button class="bigFont wrong" type="button" onclick="markRight(${problems[i].idwork})">Correct</button>
											</#if>
										<#else>
											<button class="bigFont" type="button" onclick="markRight(${problems[i].idwork})">Correct</button>
										</#if>
									</td>
									<td>
										<button class="bigFont" type="button" onclick="markWrong(${problems[i].idwork})">Wrong</button>
									</td>
								</tr>
							</#if>	
						</#if>
						<#if showAnswer != 0>
							<tr class="edge">
								<td>
									<img id="myImage2" class="center-fit" src=${problems[i].problemanswerdetail} />
								</td>
							</tr>	
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
			</table>
		</#if>
		
	</body>
	<script>
		function markRight(idwork) {
			var url = "/hhipsair/Work?idwork="+idwork+"&workmark=0";
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: url,
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: false,
				success: function(msg) {
			    	window.location.reload();
				},
				error: function(msg) {
			    	window.location.reload()
			    }
			})
		}
		function markWrong(idwork) {
			var url = "/hhipsair/Work?idwork="+idwork+"&workmark=1";
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: url,
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: false,
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