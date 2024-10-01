<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Pos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body{
            background:#2F4F4F;
            width: 100%;
            height: 100vh;
        }

        .img-inner{
            width: 100%;
        }
        .img-inner img{
            width: 100%;
            height: 100vh;
            overflow: hidden;
            object-position: center;
            object-fit: contain;
            opacity: 0.6;


        }
        .btn-warning{
            background:#f1f1f1 !important;
            border: none;
            outline: none;
        }
        .second-div{
            width: 100%;
        }
        .custom-btn{

            padding: 10px 30px;
            outline: none;
            border: none;
            border-radius: 5px;
            width: 200px;



        }
        /* .custom-btn-parent{


              display: flex;
             align-items: center;
             justify-content: space-between;
             margin: auto; }*/
             .nav-list{
                /* display: none; */

             }
             @media only screen and (max-width: 600px)  {
                .custom-btn{
                    margin-bottom: 30% !important;




                }


             }







    </style>
</head>
<body>
    <div class="container">
        <div class="row d-flex align-items-center justify-between">
            <div class="col-lg-8 img-wrapper">
                <div class="img-inner">
                    <img src="{{ asset('wel/phishing-account-concept_23-2148533311.jpg') }}" alt="">
                </div>

            </div>
            <div class="col-lg-4  ">

                 <ul class="nav navbar-nav text-center nav-list">
                    <li style="margin-top: 5%"><a href="{{ route('custom.auth.admin') }}" class="btn btn-warning">Admin Login</a></li>
                    <li style="margin-top: 5%"><a href="{{ route('custom.auth.depo') }}" class="btn btn-warning">Depo Login</a></li>
                    <li style="margin-top: 5%" ><a href="{{ route('custom.auth.stockiest') }}" class="btn btn-warning">Stockiest Login</a></li>
                </ul>



            </div>
        </div>
    </div>
    <script
    src="https://code.jquery.com/jquery-3.7.1.js"
    integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
    crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>
    $('#custom_btn').click(function(){
        $('.nav-list').slideToggle('slow')
    })
</script>
</body>
</html>
