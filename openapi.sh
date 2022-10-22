INPUT="/Users/kristofkalai/Documents/GitHub/MSc-SportBuddy-iOS/Docs/swagger.yaml"
OUTPUT="/Users/kristofkalai/Downloads/"
OUTPUT_WEB="${OUTPUT}Web"
OUTPUT_IOS="${OUTPUT}iOS"
OUTPUT_BACKEND="${OUTPUT}Backend"
GENERATOR_PATH="/Users/kristofkalai/Documents/vapor-server-codegen/target"
PROJECT_NAME="SportBuddy"
VAPOR_GENERATOR_JAR="vapor-server-codegen-4.0.0.jar"
SWAGGER_GENERATOR_JAR="swagger-codegen-cli-3.0.14.jar"

openapi-generator generate -i ${INPUT} -g swift5 --additional-properties=responseAs=AsyncAwait -o ${OUTPUT_IOS}
find ${OUTPUT_IOS}/ -maxdepth 1 -type f -delete
mv -v ${OUTPUT_IOS}/OpenAPIClient/Classes/OpenAPIs/* ${OUTPUT_IOS}
rm -r ${OUTPUT_IOS}/OpenAPIClient
rm -r ${OUTPUT_IOS}/docs
rm -r ${OUTPUT_IOS}/.openapi-generator

openapi-generator generate -i ${INPUT} -g typescript-angular -o ${OUTPUT_WEB}
rm -r ${OUTPUT_WEB}/.openapi-generator
rm ${OUTPUT_WEB}/.openapi-generator-ignore
rm ${OUTPUT_WEB}/README.md
rm ${OUTPUT_WEB}/git_push.sh
rm ${OUTPUT_WEB}/.gitignore

cd ${GENERATOR_PATH} && java --add-opens=java.base/java.util=ALL-UNNAMED -cp ${VAPOR_GENERATOR_JAR}:${SWAGGER_GENERATOR_JAR} io.swagger.codegen.v3.cli.SwaggerCodegen generate -l SwiftVapor4 -i ${INPUT} -o ${OUTPUT_BACKEND} --additional-properties projectName=${PROJECT_NAME}
find ${OUTPUT_BACKEND}/ -maxdepth 1 -type f -delete
rm -r ${OUTPUT_BACKEND}/.swagger-codegen
mv -v ${OUTPUT_BACKEND}/Sources/${PROJECT_NAME}/* ${OUTPUT_BACKEND}
rm -r ${OUTPUT_BACKEND}/Sources