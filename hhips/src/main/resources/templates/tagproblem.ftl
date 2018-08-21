<html>
<head>
	<meta charset="utf-8"/>
	<title>${myTag.tagname}</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<#include "/header.ftl">
        <h1>${myTag.tagname}</h1>
        <table>
            <#list problems as p>
                <tr class="edge">
                    <td class="edge">
                        <a class="jumper notLinkText" href="#jump_${p.idproblem?c}">
                        <p>${p.problemindex}&nbsp;&nbsp;</p>
                        </a>
                    </td>
                    <td class="edge">
                        <#if p.problemlevel == 1>
                            <p>☆</p>
                        </#if>
                        <#if p.problemlevel == 2>
                            <p>☆☆</p>
                        </#if>
                        <#if p.problemlevel == 3>
                            <p>☆☆☆</p>
                        </#if>
                        <#if p.problemlevel == 4>
                            <p>☆☆☆☆</p>
                        </#if>
                    </td>
                    <td class="edge">
                        <p>${p.modulename}&nbsp;&nbsp;</p>
                    </td>

                        <#if p.workdetail??>
                            <#if p.workmark??>
                                <#if p.workmark == 0>
                                    <td><p class="right">通过</p></td>
                                <#else>
                                    <td><p class="wrong">未通过</p></td>
                                </#if>
                            <#else>
                                <td><p class="orange">待批</p></td>
                            </#if>
                            <td class="edge">
                                <p>${p.workdate?string("yyyy-MM-dd")} &nbsp;&nbsp;&nbsp;</p>
                            </td>
                            <td class="edge">
                                <p>${p.problemtotalworktime?c} &nbsp;&nbsp;</p>
                            </td>
                            <td class="edge">
                                <p>${p.problemtotalusetime?c}</p>
                            </td>
                        <#else>
                            <td class="edge">
                                <p>未做</p>
                            </td>
                        </#if>

                    </tr>
            </#list>
        </table>

        <#list problems as p>
            <table>
                <span id=jump_${p.idproblem?c}></span>
                <tr class="edge">
                    <td>
                        <p>${p.problemindex}</p>
                    </td>
                    <td>
                        <p>${p.modulename}</p>
                    </td>
                    <td>
                        <button type="button" class="normalButton" onclick="deleteProblem(${p.idproblem?c})">Delete</button>
                    </td>
                    <td>
                        <p>${p.problemlevel}</p>
                    </td>
                    <td>
                        <#if p.problemcisactive != 0>
                            <button type="button" id=active_${p.idproblem?c}" class="activeButton" onclick="activeProblem(${p.idproblem?c}, 0)">Deactive</button>
                        <#else>
                            <button type="button" id=active_${p.idproblem?c}" class="normalButton" onclick="activeProblem(${p.idproblem?c}, 5)">Active</button>
                        </#if>
                    </td>
                    <td>
                        <a href="./Problem?problemid=${p.idproblem?c}">
                        <img id="myImage" class="center-fit" src=.\${p.problemdetail} />
                        </a>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <#if p.idwork??>
                            <p>${p.workdate?string("yyyy-MM-dd")} --- ${p.usedtime?c}</p>
                            <#if p.workmark??>
                                <#if p.workmark == 0>
                                    <p class="right">-------Pass-------</p>
                                <#else>
                                    <p class="wrong">------Not Pass----</p>
                                </#if>
                            </#if>
                        <#else>
                            <p>no work recorder</p>
                        </#if>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <img id="answer" class="center-fit" src=.\${p.problemanswerdetail} />
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
            </table>

        </#list>
	</body>
	<script>

	</script>
</html>