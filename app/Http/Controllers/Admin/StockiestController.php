<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\CustomUser;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use App\Models\Depo;
use App\Models\Stockiest;
use Illuminate\Http\Request;

class StockiestController extends Controller
{
    public function stockist_list()
    {
        $stockists = Stockiest::with('user_refer', 'stockiest_refer', 'depo_refer')->latest()->get();
        return view('admin.pages.stockiest.list', [
            'stockists' => $stockists,
        ]);
    }

    public function stockeist_register()
    {
        $depos = Depo::all();
        return view('admin.pages.stockiest.create', ['depos' => $depos]);
    }

    public function stockeist_register_post(Request $request)
    {
        $request->validate([
            'stockiest_name' => ['required'],
            'stockiest_contact_person_name' => ['required'],
            'contact_number' => ['required'],
        ]);

        // Generating the stockiest_user_id
        $count = Stockiest::count() + 1;
        $id = 'itrsp-000' . $count;

        // Determine the type of stockiest_ref_id
        $refId = $request->stockiest_ref;
        $refType = '';

        if (str::startsWith($refId, 'itrsp-')) {
            $refType = 'stockiest';
            $ref_id = Stockiest::where('stockiest_user_id', $refId)->first()->id;
        } elseif (Str::startsWith($refId, 'depo-')) {
            $refType = 'depo';
            $ref_id = Depo::where('depo_user_id', $refId)->first()->id;
        } elseif (Str::startsWith($refId, 'ITRHCL-')) {
            $refType = 'user';
            $ref_id = CustomUser::where('user_id', $refId)->first()->id;
        } else {
            $refType = ''; // Handle cases where the prefix doesn't match any known type
            $ref_id = '';
        }

        if (isset($refId) && ($refType == '' || $ref_id == '')) {
            return redirect()->back()->with('error', 'Referral Stockiest not found.');
        }


        // Inserting the stockiest data including the ref type
        Stockiest::insert([
            'stockiest_name' => $request->stockiest_name,
            'stockiest_contact_person_name' => $request->stockiest_contact_person_name,
            'contact_number' => $request->contact_number,
            'stockiest_email_id' => $request->stockiest_email,
            'stockiest_address' => $request->stockiest_address,
            'depo_id' => $request->depo_id,
            'stockiest_arya' => $request->stockiest_arya,
            'stockiest_user_id' => $id,
            'password' => Hash::make($request->stockiest_password),
            'stockiest_ref' => $request->stockiest_ref,
            'stockiest_ref_id' => $ref_id == '' ? null : $ref_id,
            'stockiest_ref_id_type' => $refType, // Add this field
        ]);

        return redirect()->route('stockist.list');
    }



    public function stockeist_edit($id)
    {
        $stockiest = Stockiest::findOrFail($id);
        $depos = Depo::all();
        return view('admin.pages.stockiest.edit', compact('stockiest','depos'));
    }

    public function stockeist_update(Request $request, $id)
    {
        $request->validate([
            'stockiest_name' => ['required'],
            'stockiest_contact_person_name' => ['required'],
            'contact_number' => ['required'],
        ]);

        $stockiest = Stockiest::findOrFail($id);
        $depos = Depo::all();


        // Determine the type of stockiest_ref_id
        $refId = $request->stockiest_ref;
        $refType = '';

        if (str::startsWith($refId, 'stockiest-')) {
            $refType = 'stockiest';
            $ref_id = Stockiest::where('stockiest_user_id', $refId)->first()->id;
        } elseif (Str::startsWith($refId, 'depo-')) {
            $refType = 'depo';
            $ref_id = Depo::where('depo_user_id', $refId)->first()->id;
        } elseif (Str::startsWith($refId, 'ITRHCL-')) {
            $refType = 'user';
            $ref_id = CustomUser::where('user_id', $refId)->first()->id;
        } else {
            $refType = ''; // Handle cases where the prefix doesn't match any known type
            $ref_id = '';
        }

        if (isset($refId) && ($refType == '' || $ref_id == '')) {
            return redirect()->back()->with('error', 'Referral Stockiest not found.');
        }

        $stockiest->update([
            'stockiest_name' => $request->stockiest_name,
            'stockiest_contact_person_name' => $request->stockiest_contact_person_name,
            'contact_number' => $request->contact_number,
            'stockiest_email_id' => $request->stockiest_email,
            'stockiest_address' => $request->stockiest_address,
            'depo_id' => $request->depo_id,
            'stockiest_arya' => $request->stockiest_arya,
            'password' => Hash::make($request->stockiest_password),
            'stockiest_ref' => $request->stockiest_ref,
            'stockiest_ref_id' => $ref_id == '' ? null : $ref_id,
            'stockiest_ref_id_type' => $refType,
        ]);


        return back()->with('status', 'Stockiest Data Updated successfully.');
    }



    public function reset_password($id)
    {
        $user = Stockiest::findOrFail($id);
        $user->password = Hash::make('1122334455');
        $user->save();

        return back()->with('status', $user->stockiest_name . ' - Password has been reset successfully.');
    }

    public function stockeist_delete($id)
    {
        $stockiest = Stockiest::findOrFail($id);
        $stockiest->delete();

        return back()->with('status', 'Stockiest Data Deleted successfully.');
    }
}
