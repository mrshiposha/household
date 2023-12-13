def focused_workspace: .. | select(
    .type?=="workspace" and (
        .name?=="ws-up"
        or .name?=="ws-down"
        or .name?=="ws-left"
        or .name?=="ws-right"
    ) and select(.. | .focused?==true)
);

def focused_app: [.nodes, .floating_nodes] | .. | select(.focused?==true) | .app_id // .window_properties.class // "";

focused_workspace as $ws | {
    workspace: $ws.name,
    focused_app: focused_app,
}
