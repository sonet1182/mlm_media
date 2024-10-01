<li>
    Generation {{ $generation['generation'] }}: {{ $generation['user']->customer_name }} (ID: {{ $generation['user']->user_id }})
    @if(!empty($generation['parent']))
        <ul>
            @include('custom_user.partials.parent_generation', ['generation' => $generation['parent']])
        </ul>
    @endif
</li>
