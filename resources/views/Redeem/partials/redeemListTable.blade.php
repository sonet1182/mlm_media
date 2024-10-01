@foreach ($redeemList as $i => $data)
    <tr>
        <td>{{ $i + 1 }}</td>
        <td>{{ $data->created_at->format('d F, Y') }}</td>
        <td>{{ $data->transactions->invoice_no ?? '' }}</td>
        <td>{{ $data->users->user_id ?? '' }}</td>
        <td>{{ $data->price_value }}</td>
        <td>{{ $data->point }}</td>
        <td class="text-center">
            @if ($data->type == 'activate')
                <span class="btn btn-sm btn-success">Activate</span>
            @else
                <span class="btn btn-sm btn-primary">Repurchase</span>
            @endif
        </td>
        <td>
            <a class="btn btn-sm btn-info" href="{{ route('redeemList_details', $data->id) }}">
                <i class="fa fa-eye"></i> View Redeem
            </a>
        </td>
    </tr>
@endforeach
