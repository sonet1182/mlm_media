<?php

namespace App\Http\Controllers;

use App\Models\Contact;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Models\CustomUser;
use App\User;
use Illuminate\Support\Facades\Auth;

class TreeController extends Controller
{
    public function tree()
    {
        $id = Auth::guard('customUser')->user()->id;
        $bonus = DB::table('bonus_info')->where('contact_id', '=', $id)->where('bonus_name', '=', 'Equel Bonus')->get();
        $user=Auth::guard('customUser')->user();
        $referGroupAdmin=Auth::guard('customUser')->user();
        $contacts=CustomUser::where('user_ref_id','=',$user->user_ref_id)->get();
        $layers=CustomUser::where('place_user_id','=',$id)->orderBy('placement_side', 'asc')->get();
        return view('tree.tree', compact('bonus','contacts','user','layers','id','referGroupAdmin'));
    }

    public function childTree($uid)
    {
        $contact = DB::table('custom_users')->where('id', '=', $uid)->first();
        $id = $contact->id;
        $loggedUser=$contact;
        $referGroupAdmin=$contact;
        $layers=CustomUser::where('place_user_id','=',$referGroupAdmin->id)->orderBy('placement_side', 'asc')->get();
        return view('tree.tree', compact('contact','loggedUser','layers','id','referGroupAdmin'));
    }

    public function placement_tree_admin($id)
    {
        $user = CustomUser::findOrFail($id);
        $id = $user->id;
        $bonus = DB::table('bonus_info')->where('contact_id', '=', $id)->where('bonus_name', '=', 'Equel Bonus')->get();
        $referGroupAdmin=$user;
        $contacts=CustomUser::where('user_ref_id','=',$user->user_ref_id)->get();
        $layers=CustomUser::where('place_user_id','=',$id)->orderBy('placement_side', 'asc')->get();
        return view('tree.admin_tree', compact('bonus','contacts','user','layers','id','referGroupAdmin'));
    }

    public function childTree_admin($uid)
    {
        $contact = DB::table('custom_users')->where('id', '=', $uid)->first();
        $id = $contact->id;
        $loggedUser=$contact;
        $referGroupAdmin=$contact;
        $layers=CustomUser::where('place_user_id','=',$referGroupAdmin->id)->orderBy('placement_side', 'asc')->get();
        return view('tree.admin_tree', compact('contact','loggedUser','layers','id','referGroupAdmin'));
    }

    //Sonet Update

    public function placement_tree_admin2($id)
    {
        $user = CustomUser::findOrFail($id);
        return view('admin.pages.tree.tree_view', compact('user'));
    }

    public function placement_tree_user()
    {
        $user = CustomUser::findOrFail(Auth::guard('customUser')->user()->id);
        return view('custom_user.pages.tree.tree_view', compact('user'));
    }

    public function placement_tree_id_user($id)
    {
        $user = CustomUser::findOrFail($id);
        return view('custom_user.pages.tree.tree_view', compact('user'));
    }


    public function placement_tree_id_user_ajax(Request $request)
{
    // Find the user
    $user = CustomUser::where('user_id', $request->user_id)->first();
    
    // Check if user exists
    if (!$user) {
        return response()->json(['status' => 'error', 'message' => 'User not found'], 404);
    }

    // Generate the tree HTML using Helper::renderTree
    $treeHtml = view('custom_user.pages.tree.partial_tree', compact('user'))->render();
    
    // Return JSON response
    return response()->json(['status' => 'success', 'html' => $treeHtml], 200);
}

}
