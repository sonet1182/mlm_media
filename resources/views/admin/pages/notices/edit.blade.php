@extends('dashboard.admin_master')

@section('title')
    Notice
@endsection

@section('admin')
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4>Edit Notice</h4>
            </div>
            <div class="card-body">
                <form action="{{ route('notice.update', $notice->id) }}" method="post">
                    @method('PUT')
                    @csrf
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                @include('layouts.session')
                            </div>

                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Content:</label>
                                    <textarea type="text" name="content" class="form-control">{{ $notice->content }}</textarea>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label>Date range:</label>
                                    <div class="input-group" id="rangeInputGroup">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="far fa-clock"></i></span>
                                        </div>
                                        <input type="text" id="daterange" name="dates"
                                            value="{{ !empty($notice) ? ($notice->start_from ? \Carbon\Carbon::parse($notice->start_from)->format('m/d/Y h:i A') : '') : '' }} - {{ !empty($notice) ? ($notice->end_to ? \Carbon\Carbon::parse($notice->end_to)->format('m/d/Y h:i A') : '') : '' }}"
                                            class="form-control" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Notice For:</label>
                                    <select name="notice_for[]" class="form-control select2" id="notice_for" multiple>
                                        <option value="user" @if (is_array($notice_for) && in_array('user', $notice_for)) selected @endif>
                                            User
                                        </option>
                                        <option value="stockiest" @if (is_array($notice_for) && in_array('stockiest', $notice_for)) selected @endif>
                                            Stockiest
                                        </option>
                                        <option value="depo" @if (is_array($notice_for) && in_array('depo', $notice_for)) selected @endif>
                                            Depo
                                        </option>
                                    </select>
                                </div>
                            </div>


                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <button type="submit" class="btn btn-primary">Edit Notice</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>



            </div>
        </div>
    </div>

    @push('js')
        <script>
            $(document).ready(function() {
                $('.select2').select2();
            });
        </script>
    @endpush
@endsection
