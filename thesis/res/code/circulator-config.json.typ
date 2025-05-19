```json
{
  "models": {
    "<model_id_name>": {
      "package": "com.example.generated",
      "state-file": "path/to/arcilator/state-file.json",
      "model": {
        "open": true,
        "all-states-open": true,
        "all-states-mutable": true,
        "all-states-type": [
          "input",
          "output",
          "register",
          "memory",
          "wire"
        ],
        "states": {
          "<state_id_name>": {
            "open": true,
            "mutable": true,
            "access": true
          },
          // ... other states
        }
      },
      "library": {
        "open": true
      },
    },
    // ... other models
  },
  "variables": {
    "<var_id_name>": "<var_value>"
  }
}
```