# Thanos query layer

The query layer is repsonsible for running PromQL queries against your
thanos stores (remote instances running the store api).


```text
┌──────────────────┐  ┌────────────┬─────────┐   ┌────────────┐
│    Store Node    │  │ Prometheus │ Sidecar │   │    Rule    │
└─────────────┬────┘  └────────────┴────┬────┘   └─┬──────────┘
              │                         │          │
              │                         │          │
              │                         │          │
              v                         v          v
        ┌─────────────────────────────────────────────────────┐
        │                      Query layer                    │
        └─────────────────────────────────────────────────────┘
                ^                  ^                  ^
                │                  │                  │
       ┌────────┴────────┐  ┌──────┴─────┐       ┌────┴───┐
       │ Alert Component │  │ Dashboards │  ...  │ Web UI │
       └─────────────────┘  └────────────┘       └────────┘
```

## See also

* https://thanos.io/tip/thanos/design.md/
