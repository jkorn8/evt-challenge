import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, ScanCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

export const handler = async (event) => {
    const getSpellsCommand = new ScanCommand({
        TableName: "evt-spells",
        ConsistentRead: true,
    });

    const response = await docClient.send(getSpellsCommand);
    console.log(response);

    if (response.$metadata.httpStatusCode !== 200) {
        return apiResponse(400, "Failed to get answers from database");
    }

    return apiResponse(200, response.Items);
}

const apiResponse = (statusCode, message) => {
    return {
        statusCode: statusCode,
        headers: {
            "Access-Control-Allow-Headers" : "Content-Type",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "OPTIONS,POST,GET",
            "Access-Control-Allow-Credentials": true, 
        },
        body: JSON.stringify(message),
    };
}