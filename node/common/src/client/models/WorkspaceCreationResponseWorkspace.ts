/* tslint:disable */
/* eslint-disable */
/**
 * Theia.cloud API
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * The version of the OpenAPI document: 0.8.0
 * 
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

import { exists } from '../runtime';

/**
 * 
 * @export
 * @interface WorkspaceCreationResponseWorkspace
 */
export interface WorkspaceCreationResponseWorkspace {
    /**
     * The name of the workspace
     * @type {string}
     * @memberof WorkspaceCreationResponseWorkspace
     */
    name: string;
    /**
     * The label of the workspace
     * @type {string}
     * @memberof WorkspaceCreationResponseWorkspace
     */
    label: string;
    /**
     * The app this workspace was used with.
     * @type {string}
     * @memberof WorkspaceCreationResponseWorkspace
     */
    appDefinition?: string;
    /**
     * The user identification, usually the email address.
     * @type {string}
     * @memberof WorkspaceCreationResponseWorkspace
     */
    user: string;
    /**
     * Whether the workspace is in use at the moment.
     * @type {boolean}
     * @memberof WorkspaceCreationResponseWorkspace
     */
    active: boolean;
}

/**
 * Check if a given object implements the WorkspaceCreationResponseWorkspace interface.
 */
export function instanceOfWorkspaceCreationResponseWorkspace(value: object): boolean {
    let isInstance = true;
    isInstance = isInstance && "name" in value;
    isInstance = isInstance && "label" in value;
    isInstance = isInstance && "user" in value;
    isInstance = isInstance && "active" in value;

    return isInstance;
}

export function WorkspaceCreationResponseWorkspaceFromJSON(json: any): WorkspaceCreationResponseWorkspace {
    return WorkspaceCreationResponseWorkspaceFromJSONTyped(json, false);
}

export function WorkspaceCreationResponseWorkspaceFromJSONTyped(json: any, ignoreDiscriminator: boolean): WorkspaceCreationResponseWorkspace {
    if ((json === undefined) || (json === null)) {
        return json;
    }
    return {
        
        'name': json['name'],
        'label': json['label'],
        'appDefinition': !exists(json, 'appDefinition') ? undefined : json['appDefinition'],
        'user': json['user'],
        'active': json['active'],
    };
}

export function WorkspaceCreationResponseWorkspaceToJSON(value?: WorkspaceCreationResponseWorkspace | null): any {
    if (value === undefined) {
        return undefined;
    }
    if (value === null) {
        return null;
    }
    return {
        
        'name': value.name,
        'label': value.label,
        'appDefinition': value.appDefinition,
        'user': value.user,
        'active': value.active,
    };
}
