
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