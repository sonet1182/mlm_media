<li style="">
    <a href="#">
        {{ $referral['user']->customer_name }}
        <div>(ID: {{ $referral['user']->user_id }})</div>
    </a>
    @if(count($referral['children']) > 0)
        <ul>
            @foreach($referral['children'] as $child)
                @include('custom_user.partials.referral', ['referral' => $child])
            @endforeach
        </ul>
    @endif
</li>