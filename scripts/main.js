// scrollTo function
function scrollToId(id) {
    var position = document.getElementById(id).offsetTop;
    window.scrollTo({
        top: position,
        behavior: 'smooth'
    });
}

// helper function for gettting DOM element by id
function getElementById(element) {
    return document.getElementById(element);
}



function submitToAPI(e) {
    e.preventDefault();
    var URL = "https://6rw4esqswe.execute-api.us-east-1.amazonaws.com/Prod/contact-us";

    var Namere = /[A-Za-z]{1}[A-Za-z]/;
    if (!Namere.test($("#name").val())) {
        alert("Name can not be less than 2 characters");
        return;
    }

    if ($("#email").val() == "") {
        alert("Please enter your email address");
        return;
    }
    
    if ($("#message").val().length <= 100) {
        alert("Please enter your message and it should be longer than 100 characters");
        return;
    }


    var reeamil = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,6})?$/;
    if (!reeamil.test($("#email").val())) {
        alert("Please enter a valid email address");
        return;
    }

    var name = $("#name").val();
    var email = $("#email").val();
    var desc = $("#message").val();
    var data = {
        name: name,
        email: email,
        desc: desc
    };

    $.ajax({
        type: "POST",
        url: "https://6rw4esqswe.execute-api.us-east-1.amazonaws.com/Prod/contact-us",
        dataType: "json",
        crossDomain: "true",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),


        success: function() {
            // clear form and show a success message
            var SuccessMessage = `<p style="color: #84423a;yte3position: relative;top: -2rem;font-weight: bold;">Message successfully sent!</p>`;
            $(".contact-container").append(SuccessMessage)
            document.getElementById("contact-form").reset();
            location.reload();
        },
        error: function() {
            // show an error message
            alert("Sorry, message did not send successfully!");
        }
    });
}

