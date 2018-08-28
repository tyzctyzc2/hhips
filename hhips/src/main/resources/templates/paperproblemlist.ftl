<html>
<head>
   <meta charset="utf-8"/>
   <title>${papername}</title>
   <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
   <script type="text/javascript" src="./chart/highcharts.js"></script>
   <script type="text/javascript" src="./chart/piechart4problem.js"></script>
   <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">

</head>
   <body>
       <#if showAnswer != 0>
           <div>
            <#include "/header.ftl">
            </div>
            <div>
            <button class="bigFont" type="button" onclick="activeWholePaper(${idpaper})">Active All Problem in Paper</button>
            </div>
        </#if>
        <div>
        <a href="./Problem?paperid=${idpaper}&noFormat=1">
            <p>${papername}</p>
        </a>
        </div>

      <#if showAnswer != 0>
         <#if max != -1>
            <table>
                <tr>
                    <td>
                        <div id="container" style="width: 550px; height: 400px; margin: 0 auto"></div>
                    </td>
                </tr>
            </table>
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
                                    <p class="wrong">Active</p>
                                <#else>
                                    <p>Hold</p>
                                </#if>
                            </td>

                        <#if problems[i].workdetail??>
                           <td class="edge">
                              <p>${works[i]?size} &nbsp;&nbsp;</p>
                           </td>
                           <td class="edge">
                                <#if (stars[i] > 0)>
                                    <p class="right">🌟</p>
                                </#if>
                                <#if (stars[i] == 0)>
                                    <p></p>
                                </#if>
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
                <#if problems[i].problemstatus == 1>
                    <button class="bigFont" type="button" onclick="activeProblem(${problems[i].idproblem?c}, ${problems[i].paperproblemid?c})">De Active</button>
                <#else>
                    <button class="bigFont" type="button" onclick="activeProblem(${problems[i].idproblem?c}, ${problems[i].paperproblemid?c})">Active</button>
                </#if>
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
                        <select class="bigFont" id="reasonSelect${problems[i].idwork?c}" onchange="postWorkReason(${problems[i].idwork?c})">
                            <option value="0">未设置</option>
                                <#list allReason as reason>
                                    <#if problems[i].reason??>
                                        <#if reason.idreason==problems[i].reason>
                                            <option selected="selected" value=${reason.idreason}>${reason.reasonname}</option>
                                        <#else>
                                            <option value=${reason.idreason}>${reason.reasonname}</option>
                                        </#if>
                                    <#else>
                                        <option value=${reason.idreason}>${reason.reasonname}</option>
                                    </#if>
                                </#list>
                        </select>
                        <select class="bigFont" id="starReasonSelect${problems[i].idwork?c}" onchange="postWorkStarReason(${problems[i].idwork?c})">
                            <option value="0">未设置</option>
                            <#list allStarReason as starReason>
                                <#if problems[i].idstarreason??>
                                    <#if starReason.idstarreason==problems[i].idstarreason>
                                        <option selected="selected" value=${starReason.idstarreason}>${starReason.starreasonname}</option>
                                    <#else>
                                        <option value=${starReason.idstarreason}>${starReason.starreasonname}</option>
                                    </#if>
                                <#else>
                                    <option value=${starReason.idstarreason}>${starReason.starreasonname}</option>
                                </#if>
                            </#list>
                        </select>
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
        var problemDone = ${problemDone};
        var problemNotStart = ${problemNotStart};
        var problemNotPass = ${problemNotPass};
        var problemTotal = ${problemTotal};
        var timeTotal = ${totalTime};

       var idpaper = ${idpaper};
       function activeProblem(idproblem, paperproblemid) {
            var pData = {};
            pData.idproblem=idproblem;
            pData.paperproblemid=paperproblemid;
            pData.paperid=idpaper;
            var url = "./Paper/problem/active";
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
       function postWorkReason(idWork) {
            var pData = {};
            pData.idwork=idWork;
            pData.reason=$("#reasonSelect"+idWork).val();
            console.log(pData.reason);
            var url = "./Work/reason";
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

       function postWorkStarReason(idWork) {
            var pData = {};
            pData.idwork=idWork;
            pData.idstarreason=$("#starReasonSelect"+idWork).val();
            console.log(pData.reason);
            var url = "./Work/starreason";
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