
function postTag() {
    var pData = {};
    pData.tagname = $( "#newTagName" ).val();

    $.ajax({
        type: "POST", // 上传文件要用POST
        url: "./tag/add",
        dataType : "json",
        processData: false,  // 注意：不要 process data
        contentType: false,  // 注意：不设置 contentType
        data: JSON.stringify(pData),
        success: function(msg) {
            console.log('tag changed');
            console.log(msg);
            window.location.reload();
        },
        error: function(msg) {
            console.log(msg);
            window.location.reload()
        }
    })
}

function changePaperStatus(idpaper, isactive) {
    var pData = {};
    pData.idpaper = idpaper;
    pData.isactive = isactive;

    console.log(JSON.stringify(pData));
    $.ajax({
        type: "POST", // 上传文件要用POST
        url: "./Paper",
        dataType : "json",
        processData: false,  // 注意：不要 process data
        contentType: false,  // 注意：不设置 contentType
        data: JSON.stringify(pData),
        success: function(msg) {
            console.log('success');
            console.log(msg);
            window.location.reload();
        },
        fail: function(msg) {
            console.log('failed');
            console.log(msg);
        }
    })
}

function goStageSource() {
    window.location.href = "./Source?stage=" + localStorage.stage;
}

function goStageFilter() {
    window.location.href = "./filter?stage=" + localStorage.stage;
}

function hideToast() {
    console.log("time is up.......");
    $('#toast').attr('class', 'myToast');
}

function toastFunction(newMsg) {
    $("#toast").text(newMsg);
    $('#toast').attr('class', 'myToastShow');
    setTimeout(hideToast, 2000);
}