using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectTutOne : MonoBehaviour
{
    float rotateSpeed = 30f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(new Vector3(0, rotateSpeed, 0) * Time.deltaTime);
    }
}
