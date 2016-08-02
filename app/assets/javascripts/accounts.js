$(function () {
    $(document).on('click', '#generate-password', function () {
        $.ajax({
            url: '/accounts/generate_password',
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                $('#password').val(response.suggested_password);
            },
            error: function (errMsg) {
            }
        });
    });
});