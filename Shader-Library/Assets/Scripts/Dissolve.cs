using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dissolve : MonoBehaviour
{

    private Material shaderMat;
    private float _Amount;

    // Start is called before the first frame update
    void Start()
    {
        _Amount = 0;
        shaderMat = GetComponent<MeshRenderer>().material;        
    }

    // Update is called once per frame
    void Update()
    {
        shaderMat.SetFloat("_Amount", _Amount);
        _Amount += Time.deltaTime;

        if ( _Amount > 1)
        {
            _Amount = 0;
        }
    }
}
