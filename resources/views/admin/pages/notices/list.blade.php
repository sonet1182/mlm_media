@extends('dashboard.admin_master')
@section('admin')
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div class="d-flex">
                    <div style="">
                        <h4>Notice List</h4>
                    </div>
                    <div class="ml-auto">
                        <a href="{{ route('notice.create') }}" class="btn btn-primary">Add Notice</a>
                    </div>
                </div>
            </div>
            <div class="card-body">

                @include('layouts.session')

                <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Serial</th>
                                <th>Content</th>
                                <th>Notice For</th>
                                <th>Start From</th>
                                <th>End To</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            @foreach ($notices as $i => $notice)
                                <tr>
                                    <td>{{ $i + 1 }}</td>
                                    <td>{{ $notice->content }}</td>
                                    <td>
                                        @foreach (json_decode($notice->notice_for) as $userType)
                                            <span class="badge badge-primary">{{ ucfirst($userType) }}</span>
                                        @endforeach
                                    </td>
                                    <td>{{ $notice->start_from->format('d F, Y') }}</td>
                                    <td>{{ $notice->end_to->format('d F, Y') }}</td>

                                    <td>
                                        <div class="">
                                            <a href="{{ route('notice.edit', $notice->id) }}"
                                                class="shadow btn btn-primary btn-sm sharp"><i class="fa fa-edit"></i></a>

                                            <form action="{{ route('notice.destroy', $notice->id) }}" method="POST"
                                                style="display: inline;">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="shadow btn btn-danger btn-sm sharp"
                                                    onclick="return confirm('Are you sure to delete this item?');">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </form>

                                        </div>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
@endsection

@push('js')
<script>
    $(function() {
        $("#example1").DataTable({
            "order": [],
            "responsive": false,
            "lengthChange": true,
            "autoWidth": true,
            "buttons": [{
                    extend: 'csv',
                },
                {
                    extend: 'excel',
                },
                'colvis'
            ]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    });
</script>
@endpush
