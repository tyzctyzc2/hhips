<html>
    <head>
        <meta charset="utf-8"/>
        <title>${papername}</title>
        <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="./chart/highcharts.js"></script>
        <script type="text/javascript" src="./chart/piechart4problem.js"></script>
        <script type="text/javascript" src="./js/common.js"></script>
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
            <#if paperDetail.isactive == 1>
                <button type="button" class="picked right largeFont" onclick="changePaperStatus(${idpaper},1)">In Edit</button>
            <#else>
                <button type="button" class="picked largeFont" onclick="changePaperStatus(${idpaper},1)">In Edit</button>
            </#if>
            <#if paperDetail.isactive == 2>
                <button type="button" class="picked right largeFont" onclick="changePaperStatus(${idpaper},2)">Active</button>
            <#else>
                <button type="button" class="picked largeFont" onclick="changePaperStatus(${idpaper},2)">Active</button>
            </#if>
            <#if paperDetail.isactive == 3>
                <button type="button" class="picked right largeFont" onclick="changePaperStatus(${idpaper},3)">Done</button>
            <#else>
                <button type="button" class="picked largeFont" onclick="changePaperStatus(${idpaper},3)">Done</button>
            </#if>
            <#if paperDetail.isactive == 4>
                <button type="button" class="picked right largeFont" onclick="changePaperStatus(${idpaper},4)">Hold</button>
            <#else>
                <button type="button" class="picked largeFont" onclick="changePaperStatus(${idpaper},4)">Hold</button>
            </#if>
            <#if paperDetail.isactive == 5>
                <button type="button" class="picked right largeFont" onclick="changePaperStatus(${idpaper},5)">Archive</button>
            <#else>
                <button type="button" class="picked largeFont" onclick="changePaperStatus(${idpaper},5)">Archive</button>
            </#if>
        </#if>
        <div class="sameLine">
            <a href="./Problem?paperid=${idpaper}&noFormat=1">
                <p>${papername}</p>
            </a>
            <a href="./Problem?paperid=${idpaper}&active=1">
                <p>(A)</p>
            </a>
            <a href="./Problem?paperid=${idpaper}&noFormat=1&active=1">
                <p>(AN)</p>
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
                <table class="dmmtable">
                    <#list 0..max as i>
                        <tr>
                            <td>
                                <a class="jumper notLinkText" href="#jump_${problems[i].idproblem?c}">
                                    <p>[${i+1}]</p>
                                </a>
                            </td>
                            <td>
                                <a class="jumper notLinkText" href="#jump_${problems[i].idproblem?c}">
                                    <p>${problems[i].problemindex}&nbsp;&nbsp;</p>
                                </a>
                            </td>
                            <td>
                                <a class="jumper notLinkText" href="#jump_${problems[i].idproblem?c}">
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
                                </a>
                            </td>
                            <td>
                                <a class="jumper notLinkText" href="#jump_${problems[i].idproblem?c}">
                                    <p>${problems[i].modulename}&nbsp;&nbsp;</p>
                                </a>
                            </td>
                            <td class="picked" onclick="activeProblem(${problems[i].idproblem?c}, ${problems[i].paperproblemid?c})">
                                <#if problems[i].problemstatus == 1>
                                    <p class="wrong">Active</p>
                                <#else>
                                    <p>Hold</p>
                                </#if>
                            </td>

                        <#if problems[i].workdetail??>
                           <td>
                              <p>${works[i]?size} &nbsp;&nbsp;</p>
                           </td>
                           <td>
                                <#if (stars[i] > 0)>
                                    <p class="right">🌟</p>
                                <#elseif (eggs[i] > 0)>
                                    <p class="wrong">🌟</p>
                                <#else>
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
                                        <td><p class="orange">待批</p></td>
                           </#if>
                           <td class="sameLineB oneLineText">
                                <p class="right">${problems[i].workdate}</p>
                                <#if problems[i].starttime??>
                                    <button class="wrong oneLineText" type="button" onclick="stopCorrect(${problems[i].idwork?c})">完成改错</button>
                                <#else>
                                    <button class="right oneLineText" type="button" onclick="doCorrect(${problems[i].idwork?c})">开始改错</button>
                                </#if>
                           </td>
                        <#else>
                           <td>
                              <button type="button" onclick="removeProblem(${problems[i].idproblem?c}, ${problems[i].paperproblemid?c})">Remove</button>
                           </td>
                        </#if>
                        <td>
                            <#list works[i] as work>
                                <#if work.workmark??>
                                    <#if work.workmark == 0>
                                        <#if work.usedtime == 0>
                                            <p style="height: 20px; float:left; width:10px;background-color:green">${work.usedtime?c}</p>
                                        <#else>
                                            <p style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:green">${work.usedtime?c}</p>
                                                </#if>
                                            <#else>
                                                <#if work.usedtime == 0>
                                                    <p style="height: 20px; float:left; width:10px;background-color:red">${work.usedtime?c}</p>
                                                <#else>
                                                    <p style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:red">${work.usedtime?c}</p>
                                                </#if>
                                            </#if>
                                        <#else>
                                            <p style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:orange">${work.usedtime?c}</p>
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
            <#if active == 0>
                <table style="font-size:  x-large;">
                   <span id=jump_${problems[i].idproblem?c}></span>
                   <tr>
                      <td>
                            <div>[${i+1}]</div>
                            <div class="picked" onclick="window.open('./Problem?problemid=${problems[i].idproblem?c}')">
                                <img id="myImage" class="center-fit" src=.\${problems[i].problemdetail} />
                            </div>
                            <#if problems[i].problemdetailb??>
                                <img id="myImage" class="center-fit" src=.\${problems[i].problemdetailb} />
                            </#if>
                            <#if problems[i].problemdetailc??>
                                <img id="myImage" class="center-fit" src=.\${problems[i].problemdetailc} />
                            </#if>
                      </td>
                   </tr>
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
                      <tr>
                          <td>
                              <br></br>
                          </td>
                          <td>
                              <br></br>
                          </td>
                      </tr>
                    </#if>
                </table>
            <#else>
                <#if active == problems[i].problemstatus>
                    <table style="font-size:  x-large;">
                       <span id=jump_${problems[i].idproblem?c}></span>
                       <tr>
                          <td>
                                <div>[${i+1}]</div>
                                <div class="picked" onclick="window.open('./Problem?problemid=${problems[i].idproblem?c}')">
                                    <img id="myImage" class="center-fit" src=.\${problems[i].problemdetail} />
                                </div>
                          </td>
                       </tr>
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
                           <tr>
                               <td>
                                   <br></br>
                               </td>
                               <td>
                                   <br></br>
                               </td>
                           </tr>
                       </#if>
                    </table>
                </#if>
            </#if>
            <#if showAnswer != 0>
                <#if problems[i].problemstatus == 1>
                    <button class="bigFont" type="button" onclick="activeProblem(${problems[i].idproblem?c}, ${problems[i].paperproblemid?c})">De Active</button>
                <#else>
                    <button class="bigFont" type="button" onclick="activeProblem(${problems[i].idproblem?c}, ${problems[i].paperproblemid?c})">Active</button>
                </#if>
               <#if problems[i].workdetail??>
                  <table style="font-size:  x-large;">
                     <tr>
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
                     <tr>
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
                  <tr>
                     <td>
                        <img id="myImage2" class="center-fit" src=.\${problems[i].problemanswerdetail} />
                     </td>
                  </tr>
               </table>
            </#if>
         </#list>
      </#if>
    <br>
    <br>
    <br>
    <br>
    <#if showAnswer != 0>
        <h1 class="bottomArea">
            <#list 0..max as i>
                <a class="jumper notLinkText sameLine" href="#jump_${problems[i].idproblem?c}">
                    <#if problems[i].problemstatus == 1>
                        <p class="orange">[${i+1}]</p>
                    <#else>
                        <p class="orange">${i+1}</p>
                    </#if>
                    <#if problems[i].workdetail??>
                        <#if problems[i].workmark??>
                            <#if problems[i].workmark == 0>
                                <div class="sameLine right">√</div>
                            <#else>
                                <div class="sameLine wrong">×</div>
                            </#if>
                        </#if>
                    </#if>
                </a>
            </#list>
            <#if afterPaper != 0>
                <a href="./Problem?paperid=${afterPaper?c}&showanswer=1">
                    <p class="sameLine floatRight">→</p>
                </a>
            </#if>

            <div class="sameLine floatRight">&nbsp;&nbsp;</div>
            <#if beforePaper != 0>
                <a href="./Problem?paperid=${beforePaper?c}&showanswer=1">
                    <p class="sameLine floatRight">←</p>
                </a>
            </#if>
            <br>
            <p>---------------------------------</p>
        </h1>
    </#if>
    </body>
    <script>
        var problemDone = ${problemDone};
        var problemNotStart = ${problemNotStart};
        var problemNotPass = ${problemNotPass};
        var problemTotal = ${problemTotal};
        var timeTotal = ${totalTime};

        var idpaper = ${idpaper?c};
        function removeProblem(idproblem, paperproblemid) {
            var pData = {};
            pData.idproblem=idproblem;
            pData.paperproblemid=paperproblemid;
            pData.paperid=idpaper;
            var url = "./Paper/problem/remove";
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
        function doCorrect(idWork) {
            var url = "./correct/start?workid=" + idWork;
            $.ajax({
                type: "POST", // 上传文件要用POST
                url: url,
                dataType : "json",
                processData: false,  // 注意：不要 process data
                contentType: false,  // 注意：不设置 contentType
                success: function(msg) {
                    window.location.reload();
                },
                error: function(msg) {
                    window.location.reload()
                }
            })
        }
        function stopCorrect(idWork) {
            var url = "./correct/stop?workid=" + idWork;
            $.ajax({
                type: "POST", // 上传文件要用POST
                url: url,
                dataType : "json",
                processData: false,  // 注意：不要 process data
                contentType: false,  // 注意：不设置 contentType
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