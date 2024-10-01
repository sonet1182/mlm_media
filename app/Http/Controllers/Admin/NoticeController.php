<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Notice;
use Carbon\Carbon;
use Illuminate\Http\Request;

class NoticeController extends Controller
{
    public function index(){
        $notices = Notice::latest()->get();
        return view('admin.pages.notices.list', compact('notices'));
    }


    public function create(){
        return view('admin.pages.notices.create');
    }

    
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'notice_for' => 'required',
            'dates' => 'required',
        ]);

        if ($validatedData['dates']) {
            list($startTimestamp, $endTimestamp) = $this->extractTimestamps($validatedData['dates']);
            $validatedData['start_from'] = Carbon::createFromTimestamp($startTimestamp);
            $validatedData['end_to'] = Carbon::createFromTimestamp($endTimestamp);
        } else {
            $validatedData['start_from'] = null;
            $validatedData['end_to'] = null;
        }

        unset($validatedData['dates']);

        $validatedData['notice_for'] ??= [];
        $validatedData['notice_for'] = json_encode($validatedData['notice_for']);

        Notice::create([
            'content' => $request->input('content'),
            'start_from' => $validatedData['start_from'],
            'end_to' => $validatedData['end_to'],
            'notice_for' => $validatedData['notice_for'],
        ]);

        return redirect()->route('notice.index')->with('status', 'Notice Created Successfully');
    }

    private function extractTimestamps($range)
    {
        $timestamps = explode(' - ', $range);
        $startTimestamp = strtotime($timestamps[0]);
        $endTimestamp = strtotime($timestamps[1]);

        return [$startTimestamp, $endTimestamp];
    }


    public function edit($id){
        $notice = Notice::findOrFail($id);
        $notice_for = json_decode($notice->notice_for);
        return view('admin.pages.notices.edit', compact('notice', 'notice_for'));
    }


    public function update(Request $request, $id)
    {
        $notice = Notice::findOrFail($id);

        $validatedData = $request->validate([
            'notice_for' => 'required',
            'dates' => 'required',
        ]);

        if ($validatedData['dates']) {
            list($startTimestamp, $endTimestamp) = $this->extractTimestamps($validatedData['dates']);
            $validatedData['start_from'] = Carbon::createFromTimestamp($startTimestamp);
            $validatedData['end_to'] = Carbon::createFromTimestamp($endTimestamp);
        } else {
            $validatedData['start_from'] = null;
            $validatedData['end_to'] = null;
        }

        unset($validatedData['dates']);

        $validatedData['notice_for'] ??= [];
        $validatedData['notice_for'] = json_encode($validatedData['notice_for']);


        $notice->update([
            'content' => $request->input('content'),
            'start_from' => $validatedData['start_from'],
            'end_to' => $validatedData['end_to'],
            'notice_for' => $validatedData['notice_for'],
        ]);

        return back()->with('status', 'Notice Created Successfully');
    }

    public function show($id)
    {}

    public function destroy($id)
    {
        $product = Notice::findOrFail($id);
        $product->delete();

        return redirect()->back()->with('status', 'Notice Removed!');
    }


}
