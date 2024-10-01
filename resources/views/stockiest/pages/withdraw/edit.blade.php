<form id="updateForm" class="needs-validation" action="{{ route('stockiest.user.withdraw.update', $data->id) }}" method="POST" novalidate
    enctype="multipart/form-data">
    @csrf
    @method('PUT')


    <div class="form-row">

        <div class="col-md-12 mb-3">
            <h4 class="text-center">Amount: {{ $data->payable_amount }} /=</h4>
            Gateway: {{ $data->gateway }}<br>
            Acc Number: {{ $data->account_number }}
            @if ($data->gateway == 'dbbl')
                <br>
                Acc Name: {{ $data->account_name }} <br>
                Bank Name: {{ $data->bank_name }} <br>
                Branch Name: {{ $data->bank_branch }} <br>
                Routing Number: {{ $data->routing_number }} <br>
                Swift Code: {{ $data->swift_code }}
            @endif
        </div>

        <hr>

        <div class="col-md-12 mb-3">
            <label for="validationCustom01">Status</label>

            <select class="form-control" name="status">
                <option value="pending">Pending</option>
                <option value="paid">Paid</option>
                <option value="cancel">Cancel</option>
            </select>
        </div>
        <div class="col-md-12 mb-3">
            <label for="title">Note</label>
            <textarea class="form-control" name="note">{{ !empty($data) ? $data->note : old('note') }}</textarea>
        </div>
    </div>

    <button class="btn btn-primary" type="submit">Submit</button>

</form>
