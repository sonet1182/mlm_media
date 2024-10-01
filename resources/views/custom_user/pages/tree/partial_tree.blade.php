<div class="genealogy-tree">
    <ul>
        @if ($user)
            @php App\Helpers\Helper::renderTree($user); @endphp
        @else
            <li>No Leader Found</li>
        @endif
    </ul>
</div>