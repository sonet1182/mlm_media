<?php

namespace App\Http\Controllers;

use App\Models\CustomUser;
use App\Models\Depo;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Haruncpi\LaravelIdGenerator\IdGenerator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class DepoRegisterController extends Controller
{
    function depo_register(){
        return view('custom_depo_auth.depo');
    }
    function depo_depo_register(){
        return view('custom_depo_auth.depo_depo_register');
    }
    function depo_depo_register_user(){
        return view('custom_depo_auth.depo_depo_register_user');
    }
    function depo_depo_register_post(Request $request){
        // $num = 0+1;
        // $incr = ++$num;










        //  $sum = 1 + $incr;
        $count=0;
        $count+=1;
        $ids=Str::lower(str_replace(' ','-','DEPO-ITRHCL-000')).random_int(1,100);
        $count=Depo::count()+1;
        $id='depo-itrhcl-000'.$count;



        $depo_id='DEPO-ITRHCL-000'.uniqid();
        Depo::insert([

            'depo_name'=>$request->depo_name,
            'contact_person_name'=>$request->depo_contact_personal_name,
            'contact_number'=>$request->depo_contact_number,
            'depo_email_id'=>$request->depo_email_id,
            'depo_address'=>$request->depo_address,
            'depo_arya'=>$request->depo_arya,
            'depo_user_id'=>$id,


            'password'=>Hash::make($request->depo_user_password)



        ]);
        return  redirect()->route('depo.depo.list');

    }
    function depo_depo_register_post_user(Request $request){
        // $num = 0+1;
        // $incr = ++$num;










        //  $sum = 1 + $incr;
        $count=0;
        $count+=1;
        $ids=Str::lower(str_replace(' ','-','DEPO-ITRHCL-000')).random_int(1,100);
        $count=Depo::count()+1;
        $id='depo-itrhcl-000'.$count;



        $depo_id='DEPO-ITRHCL-000'.uniqid();
        Depo::insert([

            'depo_name'=>$request->depo_name,
            'contact_person_name'=>$request->depo_contact_personal_name,
            'contact_number'=>$request->depo_contact_number,
            'depo_email_id'=>$request->depo_email_id,
            'depo_address'=>$request->depo_address,
            'depo_arya'=>$request->depo_arya,
            'depo_user_id'=>$id,


            'password'=>Hash::make($request->depo_user_password)



        ]);
        return  redirect()->route('depo.depo.list.user');

    }
    function depo_register_post(Request $request){
        // $num = 0+1;
        // $incr = ++$num;










        //  $sum = 1 + $incr;
        $count=0;
        $count+=1;
        $ids=Str::lower(str_replace(' ','-','DEPO-ITRHCL-000')).random_int(1,100);
        $count=Depo::count()+1;
        $id='depo-itrhcl-000'.$count;



        $depo_id='DEPO-ITRHCL-000'.uniqid();
        Depo::insert([

            'depo_name'=>$request->depo_name,
            'contact_person_name'=>$request->depo_contact_personal_name,
            'contact_number'=>$request->depo_contact_number,
            'depo_email_id'=>$request->depo_email_id,
            'depo_address'=>$request->depo_address,
            'depo_arya'=>$request->depo_arya,
            'depo_user_id'=>$id,


            'password'=>Hash::make($request->depo_user_password)



        ]);
        return  redirect()->route('depo.depo.list');

    }
    function depo_list(){
        $depos=Depo::all();
        return view('custom_depo_auth.list_depo',[
            'depos'=>$depos,
        ]);
    }
    function depo_depo_list(){
        $depos=Depo::all();
        return view('custom_depo_auth.depo_depo_list',[
            'depos'=>$depos,
        ]);
    }
    function depo_depo_list_user(){
        $depos=Depo::all();
        return view('custom_depo_auth.depo_depo_list_user',[
            'depos'=>$depos,
        ]);
    }
    function depo_depo_list_user_remove($id){
        DB::table('depos')->where('depo_user_id', '=', $id)->delete();
        return back()->with('delete','Depo User Delete Successfully');


    }
    function depo_depo_list_user_view($id){
        $viewers=DB::table('depos')->where('depo_user_id','=',$id)->get();

        return view('custom_depo_auth.view',[
            'viewers'=>$viewers,

        ]);
    }
    function depo_admin_edit_post(Request $request){
        // $num = 0+1;
        // $incr = ++$num;










        //  $sum = 1 + $incr;
        $count=0;
        $count+=1;
        $ids=Str::lower(str_replace(' ','-','DEPO-ITRHCL-000')).random_int(1,100);
        $count=Depo::count()+1;
        $id='depo-itrhcl-000'.$count;



        $depo_id='DEPO-ITRHCL-000'.uniqid();
        Depo::insert([

            'depo_name'=>$request->depo_name,
            'contact_person_name'=>$request->depo_contact_personal_name,
            'contact_number'=>$request->depo_contact_number,
            'depo_email_id'=>$request->depo_email_id,
            'depo_address'=>$request->depo_address,
            'depo_arya'=>$request->depo_arya,
            'depo_user_id'=>$id,


            'password'=>Hash::make($request->depo_user_password)



        ]);
        return  redirect()->route('depo.depo.list');

    }
    function depo_admin_list_user_view($id){
        $viewers=DB::table('depos')->where('depo_user_id','=',$id)->get();

        return view('custom_depo_auth.admin_view',[
            'viewers'=>$viewers,

        ]);
    }

    function depo_depo_list_user_edit($id){
        $viewers=DB::table('depos')->where('depo_user_id','=',$id)->get();

        return view('custom_depo_auth.depo_edit',[
            'viewers'=>$viewers,

        ]);
    }
    function depo_admin_list_user_edit($id){
        $viewers=DB::table('depos')->where('depo_user_id','=',$id)->get();

        return view('custom_depo_auth.admin_edit',[
            'viewers'=>$viewers,

        ]);
    }
    function depo_list_user(){
        $depos=Depo::all();
        return view('custom_depo_auth.depo_list_for_user',[
            'depos'=>$depos,
        ]);

    }
    function depo_user_dashboard(){
        return view('dashboard.depo');
    }
    function depo_user_login(Request $request){
        if(Depo::where('depo_user_id',$request->depo_id)->exists()){
            if(Auth::guard('depo')->attempt(['depo_user_id'=>$request->depo_id,'password'=>$request->password])){
                return redirect()->route('depo.user.dashboard');

            }
            else{
                return back()->with('exists','Password Does Not Exists');

            }
           }
           else{
            return back()->with('exists','User Id Does Not Exists');
           }


     }
     function depo_user_logout(){
        Auth::guard('depo')->logout();
        return redirect()->route('welcome');
     }
     function depo_for_depo(){
        $depos=Depo::all();
        return view('custom_depo_auth.depo_for_depo',[
            'depos'=>$depos
        ]);
     }
     function depo_for_depo_register(){
        return view('custom_depo_auth.depo_register_depo');
     }
     function depo_for_depo_register_post(Request $request){
        // $num = 0+1;
        // $incr = ++$num;










        //  $sum = 1 + $incr;
        $count=0;
        $count+=1;
        $ids=Str::lower(str_replace(' ','-','DEPO-ITRHCL-000')).random_int(1,100);
        $count=Depo::count()+1;
        $id='depo-itrhcl-000'.$count;



        $depo_id='DEPO-ITRHCL-000'.uniqid();
        Depo::insert([

            'depo_name'=>$request->depo_name,
            'contact_person_name'=>$request->depo_contact_personal_name,
            'contact_number'=>$request->depo_contact_number,
            'depo_email_id'=>$request->depo_email_id,
            'depo_address'=>$request->depo_address,
            'depo_arya'=>$request->depo_arya,
            'depo_user_id'=>$id,


            'password'=>Hash::make($request->depo_user_password)



        ]);

        return  redirect()->route('depo.for.depo');

    }
    function depo_customer_list_depo(){
        $customers=CustomUser::all();
        return view('custom_depo_auth.depo_customer_list_depo',[
            'customers'=>$customers
        ]);
    }

}
