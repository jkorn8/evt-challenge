import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand, ScanCommand } from "@aws-sdk/lib-dynamodb";
import { randomUUID } from 'crypto';

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

export const handler = async (event) => {

  console.log("Running evt-post lambda");
  const { spellName, color } = JSON.parse(event.body);
  // const { spellName, color } = event.body;
  
  if (!spellName || !color)
    return apiResponse(400, JSON.stringify('Missing spellName or color'));


  const spellId = randomUUID();

  const spell = {
      "spellId": spellId,
      "spellName": spellName,
      "color": color,
  };
  
  const createSpellCommand = new PutCommand({
    TableName: 'evt-spells',
    Item: spell
  });

  const response = await docClient.send(createSpellCommand);
  
  if (response.$metadata.httpStatusCode != 200) 
    return apiResponse(500, JSON.stringify('Error creating spell'));
  
  return apiResponse(200, JSON.stringify(`Spell ${spellId} created successfully`));
};

const apiResponse = (statusCode, body) => {
  return {
    statusCode: statusCode,
    headers: {
      "Access-Control-Allow-Headers" : "Content-Type",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "OPTIONS,POST,GET",
      "Access-Control-Allow-Credentials": true,
    },
    body: JSON.stringify(body)
  };
}