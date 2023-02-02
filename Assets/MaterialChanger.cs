using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialChanger : MonoBehaviour
{
    public Material[] materialList;

    Renderer rend;

    // Start is called before the first frame update
    void Start()
    {
        rend = GetComponent<Renderer>();
        rend.enabled = true;
        rend.sharedMaterial= materialList[0];
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.Alpha1))
        {
            rend.sharedMaterial= materialList[0];
        }
        else if (Input.GetKey(KeyCode.Alpha2))
        {
            rend.sharedMaterial = materialList[1];
        }
        else if (Input.GetKey(KeyCode.Alpha3))
        {
            rend.sharedMaterial = materialList[2];
        }
        else if (Input.GetKey(KeyCode.Alpha4))
        {
            rend.sharedMaterial = materialList[3];
        }
        else if (Input.GetKey(KeyCode.Alpha5))
        {
            rend.sharedMaterial = materialList[4];
        }
        else if (Input.GetKey(KeyCode.Alpha6))
        {
            rend.sharedMaterial = materialList[5];
        }
    }
}
