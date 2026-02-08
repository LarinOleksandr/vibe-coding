# Review-Ideas Router

## Goal

Route user intent to the right action.

## Routing decision (first match wins)

| Priority | Pattern | Examples | Route |
| --- | --- | --- | --- |
| 1 | Save as idea | `save as idea: <text>` | save |
| 2 | Review ideas | `review ideas`, `what ideas do we have?`, `let’s review ideas` | review |
| 3 | Otherwise | anything else | Ask one question: “Do you want to save this as an Idea, or review existing Ideas?” |

## Payload rule (must)

Never lose the user’s content.

