# Incidents gRPC API Reference

## Overview

This document outlines the Incidents Management API. It includes various methods for managing incidents, such as retrieving incident details, listing incidents, aggregating incidents, assigning and unassigning incidents, acknowledging and resolving incidents, and more. The service is designed to handle all operations related to incident management within Coralogix.

### Prerequisites

Before you begin, please make sure you have the following:

- [API Key for Alerts, Rules & Tags to successfully authenticate.](https://coralogix.com/docs/alerts-rules-tags-api-key/)
- [Management API Endpoint that corresponds with your Coralogix subscription.](https://coralogix.com/docs/management-api-endpoints/)
- Administrator permissions to manage your services.

## Authentication

Coralogix API uses API keys to authenticate requests. You can view and [manage your API keys](https://coralogix.com/docs/alerts-rules-tags-api-key/) from the Data Flow tab in Coralogix. You need to use this API key in the Authorization request
header to successfully connect.

Example:

```markdown
grpcurl -H "Authorization: Bearer API_KEY_HERE"
```

Then, use one of our designated **[Management Endpoints](https://coralogix.com/docs/management-api-endpoints/)** to structure your header. 

```markdown
-d @ ng-api-grpc.coralogix.com:443
```

For the Incidents Service API, the service name will be `IncidentsService`.

```bash
com.coralogixapis.incidents.v1.IncidentsService/
```

The complete request header should look like this:

```bash
grpcurl -H "Authorization: Bearer API_KEY_HERE" -d @ ng-api-grpc.coralogix.com:443 com.coralogixapis.incidents.v1.IncidentsService/
```

### Sample Request 

Lists all available incidents based on specified filters and order. In this case, incidents are shown per `assignee`. The list is ordered in an unspecified direction and sorted by time created.

```bash
grpcurl -H "Authorization: Bearer APY_KEY_HERE" -d @ ng-api-grpc.coralogix.com:443 com.coralogixapis.incidents.v1.IncidentsService/ListIncidents <<EOF 
{
    "filter": {
        "assignee": [
            {
                "value": "assignee@coralogix.com"
            }
        ]},
    "order_bys": [
        {
            "direction": "ORDER_BY_DIRECTION_UNSPECIFIED",
            "incident_field": "INCIDENTS_FIELDS_CREATED_TIME"
        }
    ]
}
EOF
```

### Sample Response

```bash
{
    "incidents": [
        {
            "assignments": [
                {
                    "assigned_to": {
                        "user_id": {
                            "value": "assignee@coralogix.com"
                        }
                    },
                    "assigned_by": {
                        "user_id": {
                            "value": "assignee@coralogix.com"
                        }
                    }
                }
            ],
            "events": [],
            "contextual_labels": [
                {
                    "key": "alert_id",
                    "value": "e2e1e00f-552f-4dfc-9d24-ab9d21d4979c"
                },
                {
                    "key": "alert_name",
                    "value": "inalert"
                },
                {
                    "key": "alert_type",
                    "value": "Standard"
                },
                {
                    "key": "alert_severity",
                    "value": "Info"
                },
                {
                    "key": "alert_group_by_fields",
                    "value": "coralogix.metadata.applicationName , coralogix.metadata.subsystemName"
                },
                {
                    "key": "alert_notification_group_id",
                    "value": "ab8dee0e-063b-43c2-89a3-bdbb068ff851"
                },
                {
                    "key": "alert_notification_group_grouping_fields",
                    "value": "coralogix.metadata.applicationName , coralogix.metadata.subsystemName"
                },
                {
                    "key": "alert_notification_group_integrations_ids",
                    "value": ""
                }
            ],
            "display_labels": [
                {
                    "key": "coralogix.metadata.subsystemName",
                    "value": "coralogix-operator"
                },
                {
                    "key": "coralogix.metadata.applicationName",
                    "value": "staging"
                }
            ],
            "id": {
                "value": "cdfaf78b-27ee-401f-8d13-ebd2daa08232"
            },
            "meta_labels": [
                {
                    "key":"some_interesting_label",
                    "value": "val"
                }
            ],
            "name": null,
            "state": "INCIDENT_STATE_TRIGGERED",
            "status": "INCIDENT_STATUS_TRIGGERED",
            "description": null,
            "severity": "INCIDENT_SEVERITY_INFO",
            "created_at": {
                "seconds": "1703677320",
                "nanos": 0
            },
            "closed_at": null,
            "last_state_update_time": {
                "seconds": "1706088981",
                "nanos": 286000000
            },
            "last_state_update_key": {
                "value": "8cde7807-dedc-418b-b542-62d78fead629"
            },
            "is_muted": {
                "value": false
            }
        }
    ]
}
```

## API Endpoints

**incidents_service.proto**

### IncidentsService

The IncidentsService is designed to provide a set of functionalities and operations to facilitate the effective management, monitoring, and resolution of incidents. Here are some key methods within the IncidentsService:

| Method Name | Description |
| --- | --- |
| [ListIncidents](#listincidents) | Lists incidents based on filters. This method is used to retrieve a collection of incidents that match certain criteria. |
| [ListIncidentAggregations](#listincidentaggregations) | Lists incident aggregations. This method is  used to retrieve aggregated information about incidents, grouped by specific parameters. |
| [GetIncident](#getincident) | Retrieves detailed information about a specific incident. This method is used to get comprehensive details regarding a single incident. |
| [GetIncidentEvents](#getincidentevents) | Retrieves events associated with a particular incident. This method is  used to obtain a chronological sequence of events related to an incident. |
| [BatchGetIncident](#batchgetincident) | Retrieves details for multiple incidents. This method is designed to efficiently retrieve information for a batch of incidents in a single request. |
| [AssignIncidents](#assignincidents) | Assigns incidents to specific users or teams. This method is used for managing the assignment of incidents to responsible parties. |
| [UnassignIncidents](#unassignincidents) | Unassigns incidents from users or teams. This method is  used to remove assignment associations for incidents. |
| [AcknowledgeIncidents](#acknowledgeincidents) | Acknowledges incidents. |
| [PaginationRequest](#paginationrequest) | Retrieves pagination information for incidents. |
| [CloseIncidents](#closeincidents) | Closes incidents. |
| [DeleteIncidents](#deleteincidents) | Deletes incidents. |
| [ResolveIncidents](#resolveincidents) | Resolves incidents. |

## ListIncidents

### ListIncidentsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| filter | IncidentQueryFilter |  | Filter for listing incidents. |
| pagination | PaginationRequest |  | Pagination details. |
| order_bys | OrderBy | repeated | Ordering options for listing incidents. |

### ListIncidentsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incidents | Incident | repeated | List of incidents. |
| pagination | PaginationResponse |  | Pagination details. |

## ListIncidentAggregations

### ListIncidentAggregationsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| filter | IncidentQueryFilter |  | Filter for aggregations. |
| group_bys | GroupBy | repeated | Grouping options for aggregations. |
| pagination | PaginationRequest |  | Pagination details. |

### ListIncidentAggregationsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_aggs | IncidentAggregation | repeated | Aggregated incident data. |
| pagination | PaginationResponse |  | Pagination details. |

## GetIncident

### GetIncidentRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| id | google.protobuf.StringValue |  | ID of the incident to retrieve. |

### GetIncidentResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident | Incident |  | Retrieved incident. |

## GetIncidentEvents

### GetIncidentEventsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_id | google.protobuf.StringValue |  | ID of the incident to get events for. |

### GetIncidentEventsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_events | IncidentEvent | repeated | Events associated with the incident. |

## BatchGetIncident

### BatchGetIncidentRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| ids | google.protobuf.StringValue | repeated | IDs of incidents to be retrieved in batch. |

### BatchGetIncidentResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incidents | BatchGetIncidentResponse.IncidentsEntry | repeated | Retrieved incidents in batch. |
| not_found_ids | google.protobuf.StringValue | repeated | IDs of incidents not found. |

### BatchGetIncidentResponse.IncidentsEntry

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| key | string |  | Incident key. |
| value | Incident |  | Retrieved incident. |

## AssignIncidents

### AssignIncidentsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_ids | google.protobuf.StringValue | repeated | IDs of incidents to be assigned. |
| assigned_to | UserDetails |  | Details of the user to whom incidents are to be assigned. |

### AssignIncidentsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incidents | Incident | repeated | Assigned incidents. |

## UnassignIncidents

### UnassignIncidentsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_ids | google.protobuf.StringValue | repeated | IDs of incidents to be unassigned. |

### UnassignIncidentsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incidents | Incident | repeated | Unassigned incidents. |

## AcknowledgeIncidents

### AcknowledgeIncidentsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_ids | google.protobuf.StringValue | repeated | IDs of incidents to be acknowledged. |

### AcknowledgeIncidentsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incidents | Incident | repeated | Acknowledged incidents. |

## CloseIncidents

### CloseIncidentsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_ids | google.protobuf.StringValue | repeated | IDs of incidents to be closed. |

### CloseIncidentsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incidents | Incident | repeated | Closed incidents. |

## DeleteIncidents

### DeleteIncidentRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| id | google.protobuf.StringValue |  | ID of the incident to be deleted. |

## ResolveIncidents

### ResolveIncidentsRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_ids | google.protobuf.StringValue | repeated | IDs of incidents to be resolved. |

### ResolveIncidentsResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incidents | Incident | repeated | Resolved incidents. |

## PaginationRequest

### PaginationRequest

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| page_size | google.protobuf.UInt32Value |  | Number of items per page. |
| page_token | google.protobuf.StringValue |  | Token for the next page. |

### PaginationResponse

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| total_size | google.protobuf.UInt32Value |  | Total number of items. |
| next_page_token | google.protobuf.StringValue |  | Token for the next page. |


### AuditLogDescription

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| description | string | optional | Description for audit logging. |

### ContextualLabels

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| field_name | google.protobuf.StringValue |  | Name of the contextual label field. |
| field_value | google.protobuf.StringValue |  | Value of the contextual label. |

### GroupByValues

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_field | IncidentFieldOneOf |  | Field to group incidents by. |
| contextual_labels | ContextualLabels |  | Contextual labels for grouping incidents. |

## Incident

The incident represents an unexpected or disruptive event within your system. The definition below outlines the essential attributes associated with managing and documenting such incidents in Coralogix. Here's a detailed description of the key components:

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| id | google.protobuf.StringValue |  | Unique identifier for the incident. |
| name | google.protobuf.StringValue |  | Name of the incident. |
| state | IncidentState |  | Current state of the incident. |
| status | IncidentStatus |  | Current status of the incident. |
| assignments | Assignment | repeated | List of assignments for the incident. |
| description | google.protobuf.StringValue |  | Description of the incident. |
| severity | IncidentSeverity |  | Severity level of the incident. |
| contextual_labels | Incident.ContextualLabelsEntry | repeated | Contextual labels associated with the incident. |
| display_labels | Incident.DisplayLabelsEntry | repeated | Display labels associated with the incident. |
| events | IncidentEvent | repeated | List of events related to the incident. |
| created_at | google.protobuf.Timestamp |  | Timestamp when the incident was created. |
| closed_at | google.protobuf.Timestamp |  | Timestamp when the incident was closed. |
| last_state_update_time | google.protobuf.Timestamp |  | Timestamp of the last state update for the incident. |
| last_state_update_key | google.protobuf.StringValue |  | Key associated with the last event that caused a state change in the incident. |
| is_muted | google.protobuf.BoolValue |  | Indicates whether the incident is muted or suppressed. |

### Incident.ContextualLabelsEntry

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| key | string |  | Key of the contextual label. |
| value | string |  | Value of the contextual label. |

### Incident.DisplayLabelsEntry

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| key | string |  | Key of the display label. |
| value | string |  | Value of the display label. |

### IncidentAggregation

Incident Aggregation is specifically used for grouping and summarizing incidents based on certain criteria. This aggregation seems to provide a consolidated view of multiple incidents, offering insights into various aspects of their states, statuses, severities, assignments, and other relevant details.

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| group_bys_value | GroupByValues | repeated | Group by fields and values for the aggregation. |
| agg_state_count | IncidentStateCount | repeated | Count of incidents for each state in the aggregation. |
| agg_status_count | IncidentStatusCount | repeated | Count of incidents for each status in the aggregation. |
| agg_severity_count | IncidentSeverityCount | repeated | Count of incidents for each severity in the aggregation. |
| agg_assignments_count | IncidentAssignmentCount | repeated | Count of incidents for each assignment in the aggregation. |
| first_created_at | google.protobuf.Timestamp |  | Timestamp of the first incident created in the aggregation. |
| last_closed_at | google.protobuf.Timestamp |  | Timestamp of the last incident closed in the aggregation. |
| all_values_count | google.protobuf.UInt32Value |  | Total count of incidents in the aggregation. |
| list_incidents_id | google.protobuf.StringValue | repeated | List of incident IDs in the aggregation. |
| last_state_update_time | google.protobuf.Timestamp |  | Timestamp of the last state update in the aggregation. |

### IncidentAssignmentCount

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| assigned_to | UserDetails |  | Details of the user to whom incidents are assigned. |
| count | google.protobuf.UInt32Value |  | Count of incidents assigned to the user. |

### IncidentFieldOneOf

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| id | google.protobuf.StringValue |  | Unique identifier for the incident field. |
| severity | IncidentSeverity |  | Severity level of the incident field. |
| name | google.protobuf.StringValue |  | Name of the incident field. |
| created_at | google.protobuf.Timestamp |  | Timestamp when the incident field was created. |
| closed_at | google.protobuf.Timestamp |  | Timestamp when the incident field was closed. |
| state | IncidentState |  | State of the incident field. |
| status | IncidentStatus |  | Status of the incident field. |
| last_state_update_time | google.protobuf.Timestamp |  | Timestamp of the last state update for the incident field. |
| application_name | google.protobuf.StringValue |  | Application name associated with the incident field. |
| subsystem_name | google.protobuf.StringValue |  | Subsystem name associated with the incident field. |

### IncidentSeverityCount

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| severity | IncidentSeverity |  | Severity level. |
| count | google.protobuf.UInt32Value |  | Count of incidents for the severity level. |

### IncidentStateCount

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| state | IncidentState |  | State of the incident. |
| count | google.protobuf.UInt32Value |  | Count of incidents for the state. |

### IncidentStatusCount

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| status | IncidentStatus |  | Status of the incident. |
| count | google.protobuf.UInt32Value |  | Count of incidents for the status. |

### IncidentFields

| Name | Number | Description |
| --- | --- | --- |
| INCIDENTS_FIELDS_UNSPECIFIED | 0 | Unspecified incident field. |
| INCIDENTS_FIELDS_ID | 1 | Incident ID. |
| INCIDENTS_FIELDS_SEVERITY | 2 | Incident severity. |
| INCIDENTS_FIELDS_NAME | 3 | Incident name. |
| INCIDENTS_FIELDS_CREATED_TIME | 4 | Timestamp when the incident was created. |
| INCIDENTS_FIELDS_CLOSED_TIME | 5 | Timestamp when the incident was closed. |
| INCIDENTS_FIELDS_STATE | 6 | Current state of the incident. |
| INCIDENTS_FIELDS_STATUS | 7 | Current status of the incident. |
| INCIDENTS_FIELDS_LAST_STATE_UPDATE_TIME | 8 | Timestamp of the last state update for the incident. |
| INCIDENTS_FIELDS_APPLICATION_NAME | 9 | Application name associated with the incident. |
| INCIDENTS_FIELDS_SUBSYSTEM_NAME | 10 | Subsystem name associated with the incident. |

**incident_severity.proto**

### IncidentSeverity

| Name | Number | Description |
| --- | --- | --- |
| INCIDENT_SEVERITY_UNSPECIFIED | 0 | Unspecified incident severity. |
| INCIDENT_SEVERITY_INFO | 1 | Informational incident severity. |
| INCIDENT_SEVERITY_WARNING | 2 | Warning incident severity. |
| INCIDENT_SEVERITY_ERROR | 3 | Error incident severity. |
| INCIDENT_SEVERITY_CRITICAL | 4 | Critical incident severity. |

**incident_status.proto**

### IncidentStatus

| Name | Number | Description |
| --- | --- | --- |
| INCIDENT_STATUS_UNSPECIFIED | 0 | Unspecified incident status. |
| INCIDENT_STATUS_TRIGGERED | 1 | Incident is triggered. |
| INCIDENT_STATUS_ACKNOWLEDGED | 2 | Incident is acknowledged. |
| INCIDENT_STATUS_RESOLVED | 3 | Incident is resolved. |

**assignee.proto**

### Assignment

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| assigned_to | UserDetails |  | Details of the user to whom the incident is assigned. |
| assigned_by | UserDetails |  | Details of the user who assigned the incident. |

### UserDetails

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| user_id | google.protobuf.StringValue |  | ID of the user. |

**incident_event/incident_event_unassign.proto**

### IncidentEventUnassign

This represents an event where an incident is unassigned.

**incident_event/incident_event_acknowledge.proto**

### IncidentEventAcknowledge

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| acknowledged_by | UserDetails |  | Details of the user who acknowledged the incident. |

**incident_event/incident_event_type.proto**

### IncidentEventType

| Name | Number | Description |
| --- | --- | --- |
| INCIDENT_EVENT_TYPE_UNSPECIFIED | 0 | Unspecified incident event type. |
| INCIDENT_EVENT_TYPE_UPSERT_STATE | 2 | Incident event for upserting state. |
| INCIDENT_EVENT_TYPE_OPEN | 4 | Incident event for opening an incident. |
| INCIDENT_EVENT_TYPE_CLOSE | 5 | Incident event for closing an incident. |
| INCIDENT_EVENT_TYPE_SNOOZE_INDICATOR | 6 | Incident event for snooze indicator. |
| INCIDENT_EVENT_TYPE_ASSIGN | 7 | Incident event for assigning an incident. |
| INCIDENT_EVENT_TYPE_UNASSIGN | 9 | Incident event for unassigning an incident. |
| INCIDENT_EVENT_TYPE_ACKNOWLEDGE | 8 | Incident event for acknowledging an incident. |

**incident_event/incident_event_assign.proto**

### IncidentEventAssign

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| assignment | Assignment |  | Details of the assignment event. |

**incident_event/incident_event_originator_operational.proto**

### IncidentEventOriginatorOperational

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| system_name | google.protobuf.StringValue |  | Name of the operational system originating the event. |

**incident_event/incident_event_originator_administrative.proto**

### IncidentEventOriginatorAdministrative

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| user_id | google.protobuf.StringValue |  | ID of the administrative user originating the event. |

**incident_event/incident_event_originator_type.proto**

### OriginatorType

| Name | Number | Description |
| --- | --- | --- |
| ORIGINATOR_TYPE_UNSPECIFIED | 0 | Unspecified originator type. |
| ORIGINATOR_TYPE_OPERATIONAL | 1 | Operational originator type. |
| ORIGINATOR_TYPE_ADMINISTRATIVE | 2 | Administrative originator type. |

**incident_event/incident_event_snooze_indicator.proto**

### IncidentEventSnoozeIndicator

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| start_time | google.protobuf.Timestamp |  | Start time of the snooze period. |
| duration_minutes | google.protobuf.Int32Value |  | Duration of the snooze period in minutes. |
| user_id | google.protobuf.StringValue |  | ID of the user who initiated the snooze. |

**incident_event/incident_event.proto**

### IncidentEvent

An incident event typically refers to a specific occurrence or action related to the management and lifecycle of an incident within your system. This structured definition includes various fields to capture details about the event.

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| id | google.protobuf.StringValue |  | Unique identifier for the incident event. |
| incident_event_type | IncidentEventType |  | Type of the incident event. |
| snooze_indicator | IncidentEventSnoozeIndicator |  | Information related to snooze indicator event. |
| assignment | IncidentEventAssign |  | Information related to assignment event. |
| unassign | IncidentEventUnassign |  | Information related to unassignment event. |
| upsert_state | IncidentEventUpsertState |  | Information related to upsert state event. |
| acknowledge | IncidentEventAcknowledge |  | Information related to acknowledgment event. |
| close | IncidentEventClose |  | Information related to closure event. |
| originator_type | OriginatorType |  | Type of the originator (administrative or operational) for the incident event. |
| administrative_event | IncidentEventOriginatorAdministrative |  | Details of the administrative user who triggered the event. |
| operational_event | IncidentEventOriginatorOperational |  | Details of the operational system that triggered the event. |

**incident_event/incident_event_upsert_state.proto**

### IncidentEventUpsertState

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| state_type | UpsertIncidentStateType |  | Type of upsert state event. |
| payload | UpsertIncidentStatePayload |  | Payload associated with the upsert state event. |
| is_muted | google.protobuf.BoolValue |  | Indicates whether the incident is muted during the upsert state event. |

### UpsertIncidentStatePayload

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| cx_event_key | google.protobuf.StringValue |  | Coralogix event key associated with the incident. |


### UpsertIncidentStateType

| Name | Number | Description |
| --- | --- | --- |
| UPSERT_INCIDENT_STATE_TYPE_UNSPECIFIED | 0 | Unspecified upsert incident state type. |
| UPSERT_INCIDENT_STATE_TYPE_TRIGGERED | 1 | Upsert state for triggered incidents. |
| UPSERT_INCIDENT_STATE_TYPE_RESOLVED | 2 | Upsert state for resolved incidents. |

**incident_event/incident_event_close.proto**

### IncidentEventClose

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| closed_by | UserDetails |  | Details of the user who closed the incident. |

**incident_query_filter.proto**

### ContextualLabelValues

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| contextual_label_values | google.protobuf.StringValue | repeated | List of contextual label values. |

### IncidentQueryFilter

Incident Query Filter is used for specifying criteria when querying or filtering incidents within a your system. This definition includes various fields that can be used to filter incidents based on different attributes. 

| Field | Type | Label | Description |
| --- |  | --- | --- |
| assignee | google.protobuf.StringValue | repeated | List of assignee user IDs. |
| status | IncidentStatus | repeated | List of incident statuses. |
| state | IncidentState | repeated | List of incident states. |
| severity | IncidentSeverity | repeated | List of incident severities. |
| contextual_labels | IncidentQueryFilter.ContextualLabelsEntry | repeated | List of contextual labels and their values. |
| search_query | IncidentSearchQuery |  | Search query for incidents. |
| application_name | google.protobuf.StringValue | repeated | List of application names. |
| subsystem_name | google.protobuf.StringValue | repeated | List of subsystem names. |
| is_muted | google.protobuf.BoolValue |  | Indicates whether incidents are muted. |
| created_at_range | TimeRange |  | Filters all incidents created at the given time range |
| incident_duration_range | TimeRange |  | Filters all incidents open (alive) at the given time range |


### IncidentQueryFilter.TimeRange
| Field | Type | Label | Description |
| --- | --- | --- | --- |
| start_time | google.protobuf.Timestamp |  | Start time for filtering incidents. |
| end_time | google.protobuf.Timestamp |  | End time for filtering incidents. |

### IncidentQueryFilter.ContextualLabelsEntry

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| key | string |  | Key of the contextual label. |
| value | ContextualLabelValues |  | List of values for the contextual label. |

**incident_state.proto**

### IncidentState

| Name | Number | Description |
| --- | --- | --- |
| INCIDENT_STATE_UNSPECIFIED | 0 | Unspecified incident state. |
| INCIDENT_STATE_TRIGGERED | 1 | Incident is triggered. |
| INCIDENT_STATE_RESOLVED | 2 | Incident is resolved. |

**incident_query.proto**

### GroupBy

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_field | IncidentFields |  | Field to group incidents by. |
| contextual_label | google.protobuf.StringValue |  | Contextual label to group incidents by. |
| order_by_direction | OrderByDirection |  | Direction for ordering the grouped incidents. |

### IncidentSearchQuery

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| query | google.protobuf.StringValue |  | Search query string. |
| incident_field | IncidentFields |  | Field to search incidents by. |
| contextual_label | google.protobuf.StringValue |  | Contextual label to search incidents by. |

### OrderBy

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| incident_field | IncidentFields |  | Field for ordering incidents. |
| contextual_label | google.protobuf.StringValue |  | Contextual label for ordering incidents. |
| direction | OrderByDirection |  | Direction for ordering incidents. |

### OrderByDirection

| Name | Number | Description |
| --- | --- | --- |
| ORDER_BY_DIRECTION_UNSPECIFIED | 0 | Unspecified order direction. |
| ORDER_BY_DIRECTION_ASC | 1 | Ascending order. |
| ORDER_BY_DIRECTION_DESC | 2 | Descending order. |

### OrderByFields

| Name | Number | Description |
| --- | --- | --- |
| ORDER_BY_FIELDS_UNSPECIFIED | 0 | Unspecified order field. |
| ORDER_BY_FIELDS_ID | 1 | Order by incident ID. |
| ORDER_BY_FIELDS_SEVERITY | 2 | Order by incident severity. |
| ORDER_BY_FIELDS_NAME | 3 | Order by incident name. |
| ORDER_BY_FIELDS_CREATED_TIME | 4| Order by incident creation time. |
| ORDER_BY_FIELDS_CLOSED_TIME | 5 | Order by incident closure time. |


### ScopeDetails

| Field | Type | Label | Description |
| --- | --- | --- | --- |
| subsystem_name | google.protobuf.StringValue |  | Name of the subsystem. |
| application_name | google.protobuf.StringValue |  | Name of the application. |
