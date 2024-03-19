import io
import json
import logging
import os
import time

import oci
from fdk import response

rp = os.getenv("OCI_RESOURCE_PRINCIPAL_VERSION", "")
if rp == "2.2":
    signer = oci.auth.signers.get_resource_principals_signer()
else:
    print("use instance principal")
    signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
compute_client = oci.core.ComputeClient(config={}, signer=signer)

def handler(ctx, data: io.BytesIO = None):
    try:
        body = json.loads(data.getvalue())
        instance_id = body.get("instance_id")
    except (Exception, ValueError) as ex:
        logging.getLogger().info('error parsing json payload: ' + str(ex))
    logging.getLogger().info("Inside start compute function")
    launch_instance_status = launch_instance(instance_id)
    if launch_instance_status == True:
        return response.Response(
            ctx, response_data=json.dumps(
                {"message": f"launch instance {instance_id} is successfull"}),
            headers={"Content-Type": "application/json"}
        )
    else:
        raise Exception("launch instance is failed")

def launch_instance(instance_id: str) -> bool:
    """launch instance

    Args:
        instance_id (str): Target instance ocid

    Returns:
        bool: status of launch instance request
    """
    compute_client.instance_action(instance_id, "START")
    while True:
        time.sleep(10)
        work_request = compute_client.get_instance(instance_id)
        if work_request.data.lifecycle_state == "RUNNING":
            break
    return True
    

if __name__ == "__main__":
    launch_instance("dummy")
